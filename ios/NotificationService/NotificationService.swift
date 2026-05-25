//
//  NotificationService.swift
//  NotificationService
//
//  Created by JIzan on 12/05/26.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
    ) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        guard let bestAttemptContent = bestAttemptContent else {
            contentHandler(request.content)
            return
        }

        // ✅ Correctly parse [AnyHashable: Any] userInfo
        let userInfo = bestAttemptContent.userInfo

        // Try fcm_options.image first
        var imageUrlString: String? = nil

        if let fcmOptions = userInfo["fcm_options"] as? [String: Any] {
            imageUrlString = fcmOptions["image"] as? String
        }

        // Fallback: image directly in data payload
        if imageUrlString == nil {
            imageUrlString = userInfo["image"] as? String
        }

        guard
            let urlString = imageUrlString,
            let imageUrl = URL(string: urlString)
        else {
            // ✅ No image — still deliver the notification
            contentHandler(bestAttemptContent)
            return
        }

        downloadImage(from: imageUrl) { attachment in
            if let attachment = attachment {
                bestAttemptContent.attachments = [attachment]
            }
            contentHandler(bestAttemptContent)
        }
    }

    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler,
           let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

    private func downloadImage(from url: URL, completion: @escaping (UNNotificationAttachment?) -> Void) {
        URLSession.shared.downloadTask(with: url) { location, _, _ in
            guard let location = location else {
                completion(nil)
                return
            }
            // ✅ Use unique filename to avoid collision
            let tmpDir = URL(fileURLWithPath: NSTemporaryDirectory())
            let tmpFile = tmpDir.appendingPathComponent(
                "\(UUID().uuidString).\(url.pathExtension.isEmpty ? "jpg" : url.pathExtension)"
            )
            try? FileManager.default.moveItem(at: location, to: tmpFile)
            let attachment = try? UNNotificationAttachment(
                identifier: "image",
                url: tmpFile,
                options: nil
            )
            completion(attachment)
        }.resume()
    }
}
