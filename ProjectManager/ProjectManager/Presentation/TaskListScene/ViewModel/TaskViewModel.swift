import UIKit

final class TaskViewModel {
    func changeDateLabelColorIfExpired(with date: Date) -> UIColor {
        let dayInSeconds: Double = 3600 * 24
        let yesterday = Date(timeIntervalSinceNow: -dayInSeconds)
        return date < yesterday ? .systemRed : .label
    }
}
