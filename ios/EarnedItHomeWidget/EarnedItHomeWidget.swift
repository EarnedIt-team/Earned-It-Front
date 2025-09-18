import WidgetKit
import SwiftUI

// 1. 위젯의 타임라인을 관리하는 Provider
struct Provider: TimelineProvider {
    // Flutter 앱의 공유 데이터(UserDefaults)를 읽어오는 함수
    private func readDataFromFlutter() -> (lastPaydayTimestamp: Int, earningsPerSecond: Double) {
        // Flutter 코드에서 설정한 App Group ID와 일치해야 합니다.
        let userDefaults = UserDefaults(suiteName: "group.earnedItHomeScreen") // 본인의 App Group ID로 수정
        let timestamp = userDefaults?.integer(forKey: "lastPaydayTimestamp") ?? 0
        let earnings = userDefaults?.double(forKey: "earningsPerSecond") ?? 0.0
        return (timestamp, earnings)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), currentAmount: 1234567.0, earningsPerSecond: 1.3)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), currentAmount: 1234567.0, earningsPerSecond: 1.3)
        completion(entry)
    }

    // 위젯의 상태를 주기적으로 업데이트하는 타임라인 생성
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let sharedData = readDataFromFlutter()
        
        // 데이터가 없으면 "설정 필요" 상태 표시
        guard sharedData.lastPaydayTimestamp != 0, sharedData.earningsPerSecond > 0 else {
            let entry = SimpleEntry(date: Date(), currentAmount: -1.0, earningsPerSecond: 0.0) // -1을 설정 필요 신호로 사용
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
            return
        }

        let lastPaydayDate = Date(timeIntervalSince1970: TimeInterval(sharedData.lastPaydayTimestamp / 1000))
        let currentDate = Date()
        
        // 다음 1시간 동안 1분 간격으로 타임라인 엔트리 생성
        for minuteOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let elapsedSeconds = entryDate.timeIntervalSince(lastPaydayDate)
            let amount = elapsedSeconds * sharedData.earningsPerSecond
            let entry = SimpleEntry(date: entryDate, currentAmount: amount, earningsPerSecond: sharedData.earningsPerSecond)
            entries.append(entry)
        }

        // 1시간 후에 타임라인을 다시 생성하도록 정책 설정
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// 2. 위젯에 표시될 데이터의 구조 (모델)
struct SimpleEntry: TimelineEntry {
    let date: Date
    let currentAmount: Double
    let earningsPerSecond: Double // 초당 수익 필드 추가
}

// 3. 위젯의 실제 UI를 구성하는 View
struct HomeWidgetEntryView : View {
    var entry: Provider.Entry

    // 숫자를 세 자리 쉼표가 있는 문자열로 변환하는 포맷터
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    // 초당 수익을 소수점 한 자리로 변환하는 포맷터
    private static let perSecondFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    // 날짜에서 '월'만 추출하는 포맷터
    private static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        return formatter
    }()

    var body: some View {
        let monthString = Self.monthFormatter.string(from: entry.date)
        
        VStack(alignment: .leading, spacing: 4) {
            Text("\(monthString)월 누적 금액")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            if entry.currentAmount == -1.0 {
                Text("앱에서 수익을 설정해주세요.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            } else {
                let formattedAmount = Self.numberFormatter.string(for: entry.currentAmount) ?? "0"
                Text("\(formattedAmount) 원")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                    .minimumScaleFactor(0.5)
                    .contentTransition(.numericText())
                
                // (핵심 수정) 초당 수익 텍스트 추가
                let formattedPerSecond = Self.perSecondFormatter.string(for: entry.earningsPerSecond) ?? "0.0"
                Text("(+ \(formattedPerSecond) 원 /sec)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
    }
}

// 4. 위젯의 기본 설정
struct EarnedItHomeWidget: Widget {
    let kind: String = "EarnedItHomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                HomeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                HomeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Earned It")
        .description("현재까지 누적된 금액을 확인하세요.")
    }
}

// 5. Xcode 미리보기를 위한 설정
#Preview(as: .systemSmall) {
    EarnedItHomeWidget()
} timeline: {
    SimpleEntry(date: .now, currentAmount: 11234567.0, earningsPerSecond: 1.3)
    SimpleEntry(date: .now, currentAmount: -1.0, earningsPerSecond: 0.0)
}
