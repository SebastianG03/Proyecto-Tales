enum SectionStatus { start, end, nextChapter }

class SectionStatusHelper {
  static SectionStatus fromString(String status) {
    switch (status) {
      case 'start':
        return SectionStatus.start;
      case 'end':
        return SectionStatus.end;
      case 'nextChapter':
        return SectionStatus.nextChapter;
      default:
        return SectionStatus.start;
    }
  }
}
