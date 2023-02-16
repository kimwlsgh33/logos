import 'package:logos/src/model/entities/author.dart';

const wisdoms = ['어떤 계획이든, 무계획보다는 낫다.', ''];

final socrates = Author(
  name: '소크라테스',
  wisdoms: [
    '나는 그래도 내가 모르는 것은 안다.',
  ],
);

final epictetus = Author(
  name: '에픽테토스',
  wisdoms: [
    '인간은 선을취하고 악을피하게 되어있다.',
  ],
);

final aurelius = Author(
  name: '마르쿠스 아우렐리우스',
  wisdoms: [
    "진리는 모두에게 이득이다.",
    "잠에서 깨어나서 당신을 괴롭하던 것들은 모두 꿈에 불과했다.",
    "금이나 에메랄드가 늘 그 색깔을 유지하는 것처럼, 당신의 마음도 늘 그 색깔을 유지해야 한다.",
  ],
);

final yunhongsic = Author(
  name: '윤홍식',
  wisdoms: [
    "ego의 역량에서 올바른일을 한다.",
  ],
);

final stoics = [epictetus, socrates, aurelius];
