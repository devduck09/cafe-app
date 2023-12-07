enum Payment { cupay, card }
enum Receipt { personal, business }

enum TagFilter {
  parking,
  rooftop,
  elevator,
  familyRoom,
  petFriendly,
  brunch,
  kidsZone,
  seniorZone,
  terrace,
  signatureMenu,
  meetingRoom,
  bakery,
  roastingCafe,
  studyZone,
  smokingArea,
  photoSpot,
  scenicViewDining,
  merchandise,
}

enum TagFilterLocalTabs {
  // 상위 지역
  seoul,
  gyeonggi,
  incheon,
  gangwon,
  jeju,
  busan,
  gyeongnam,
  gyeongbuk,
  chungnam,
  chungbuk,
  jeonnam,
  jeonbuk,
}

enum TagFilterLocalLocations {
  // 1. 경남
  yangsan,
  miryang,
  gimhae,
  jangyu,
  yulha,
  jinju,
  geoje,
  tongyeong,
  gosunggun,
  changwon,
  sachun,
  namhae,
  hadong,
  masan,
  jinhae,
  otherGyeongnam,
  // 2. 경북
  pohang,
  gyeongsan,
  hayang,
  yeongcheon,
  chungdo,
  gyeongju,
  mungyeong,
  sangju,
  yeongju,
  gumi,
  gimcheon,
  chilgok,
  waegwan,
  seongju,
  uiseong,
  andong,
  uljin,
  ulleungdo,
  cheongsong,
  yeongdeok,
  // 3. 충북
  cheongju,
  jecheon,
  dangyang,
  jincheon,
  eumseong,
  chungju,
  suanbo,
  jeungpyeong,
  goesan,
  yungdong,
  boeun,
  okcheon,
  // 4. 전남
  suncheon,
  mokpo,
  muan,
  yeongam,
  yeosu,
  naju,
  damyang,
  gokseong,
  gurye,
  gwangyang,
  yeonggwang,
  jangseong,
  hampyeong,
  hwasun,
  boseong,
  haenam,
  wando,
  gangjin,
  goheung,
  jindo,
  // 5. 경기
  suwon,
  anseong,
  pyeongtaek,
  songtan,
  uijeongbu,
  osan,
  hwaseong,
  dongtan,
  ansan,
  gimpo,
  janggi,
  gurae,
  daemyunghang,
  yongin,
  goyang,
  ilsan,
  seongnam,
  bundang,
  anyang,
  pyeongchon,
  indeokwon,
  gwacheon,
  guri,
  hanam,
  gunpo,
  geumjeong,
  sanbon,
  uiwang,
  namyangju,
  gwangmyeong,
  cheolsan,
  siheung,
  gapyeong,
  yangpyeong,
  wolgok,
  jeongwang,
  oidoo,
  geobukseom,
  pocheon,
  icheon,
  gwangju,
  yeoju,
  gonjiam,
  yangju,
  dongducheon,
  yeoncheon,
  jangheung,
  // 6. 강원
  gangneung,
  yangyang,
  naksan,
  hajodae,
  inje,
  wonju,
  hoengseong,
  sokcho,
  seorak,
  gosung,
  chuncheon,
  hongcheon,
  cheorwon,
  hwacheon,
  pyeongchang,
  yeongwol,
  jeongseon,
  taebaek,
  jeongdongjin,
  donghae,
  samcheok,
  // 7. 충남
  cheonan,
  sejong,
  gyeryong,
  geumsan,
  nonsan,
  gongju,
  asan,
  seosan,
  seochun,
  buyeo,
  dangjin,
  daecheong,
  boleong,
  yesan,
  cheongyang,
  hongseong,
  // 8. 전북
  jeonju,
  gunsan,
  bieungdo,
  namwon,
  imsil,
  sunchang,
  iksan,
  muju,
  jinan,
  jangsu,
  gimje,
  buan,
  gochang,
  jeongeup,
}

Map<Enum, String> tagFilterLabels = {
  TagFilter.parking: '주차장',
  TagFilter.rooftop: '루프탑',
  TagFilter.elevator: '엘리베이터',
  TagFilter.familyRoom: '가족실',
  TagFilter.petFriendly: '반려견동반',
  TagFilter.brunch: '브런치',
  TagFilter.kidsZone: '노키즈존',
  TagFilter.seniorZone: '노시니어존',
  TagFilter.terrace: '테라스',
  TagFilter.signatureMenu: '시그니처메뉴',
  TagFilter.meetingRoom: '회의실',
  TagFilter.bakery: '베이커리',
  TagFilter.roastingCafe: '로스팅카페',
  TagFilter.studyZone: '스터디존',
  TagFilter.smokingArea: '흡연실',
  TagFilter.photoSpot: '포토스팟',
  TagFilter.scenicViewDining: '야경맛집',
  TagFilter.merchandise: '굿즈',
  // 상위 지역
  TagFilterLocalTabs.seoul: '서울',
  TagFilterLocalTabs.gyeonggi: '경기',
  TagFilterLocalTabs.incheon: '인천',
  TagFilterLocalTabs.gangwon: '강원',
  TagFilterLocalTabs.jeju: '제주',
  TagFilterLocalTabs.busan: '부산',
  TagFilterLocalTabs.gyeongnam: '경남',
  TagFilterLocalTabs.gyeongbuk: '경북',
  TagFilterLocalTabs.chungnam: '충남',
  TagFilterLocalTabs.chungbuk: '충북',
  TagFilterLocalTabs.jeonnam: '전남',
  TagFilterLocalTabs.jeonbuk: '전북',
  // 1. 경남
  TagFilterLocalLocations.yangsan: "양산",
  TagFilterLocalLocations.miryang: "밀양",
  TagFilterLocalLocations.gimhae: "김해",
  TagFilterLocalLocations.jangyu: "장유",
  TagFilterLocalLocations.yulha: "율하",
  TagFilterLocalLocations.jinju: "진주",
  TagFilterLocalLocations.geoje: "거제",
  TagFilterLocalLocations.tongyeong: "통영",
  TagFilterLocalLocations.gosunggun: "고성군",
  TagFilterLocalLocations.changwon: "창원",
  TagFilterLocalLocations.sachun: "사천",
  TagFilterLocalLocations.namhae: "남해",
  TagFilterLocalLocations.hadong: "하동",
  TagFilterLocalLocations.masan: "마산",
  TagFilterLocalLocations.jinhae: "진해",
  TagFilterLocalLocations.otherGyeongnam: "기타 경남",
  //2. 경북
  TagFilterLocalLocations.pohang: "포항",
  TagFilterLocalLocations.gyeongsan: "경산",
  TagFilterLocalLocations.hayang: "하양",
  TagFilterLocalLocations.yeongcheon: "영천",
  TagFilterLocalLocations.chungdo: "청도",
  TagFilterLocalLocations.gyeongju: "경주",
  TagFilterLocalLocations.mungyeong: "문경",
  TagFilterLocalLocations.sangju: "상주",
  TagFilterLocalLocations.yeongju: "영주",
  TagFilterLocalLocations.gumi: "구미",
  TagFilterLocalLocations.gimcheon: "김천",
  TagFilterLocalLocations.chilgok: "칠곡",
  TagFilterLocalLocations.waegwan: "왜관",
  TagFilterLocalLocations.seongju: "성주",
  TagFilterLocalLocations.uiseong: "의성",
  TagFilterLocalLocations.andong: "안동",
  TagFilterLocalLocations.uljin: "울진",
  TagFilterLocalLocations.ulleungdo: "울릉도",
  TagFilterLocalLocations.cheongsong: "청송",
  TagFilterLocalLocations.yeongdeok: "영덕",
  // 3. 충북
  TagFilterLocalLocations.cheongju: "청주",
  TagFilterLocalLocations.jecheon: "제천",
  TagFilterLocalLocations.dangyang: "당양",
  TagFilterLocalLocations.jincheon: "진천",
  TagFilterLocalLocations.eumseong: "음성",
  TagFilterLocalLocations.chungju: "충주",
  TagFilterLocalLocations.suanbo: "수안보",
  TagFilterLocalLocations.jeungpyeong: "증평",
  TagFilterLocalLocations.goesan: "괴산",
  TagFilterLocalLocations.yungdong: "영동",
  TagFilterLocalLocations.boeun: "보은",
  TagFilterLocalLocations.okcheon: "옥천",
  // 4. 전남
  TagFilterLocalLocations.suncheon: "순천",
  TagFilterLocalLocations.mokpo: "목포",
  TagFilterLocalLocations.muan: "무안",
  TagFilterLocalLocations.yeongam: "영암",
  TagFilterLocalLocations.yeosu: "여수",
  TagFilterLocalLocations.naju: "나주",
  TagFilterLocalLocations.damyang: "담양",
  TagFilterLocalLocations.gokseong: "곡성",
  TagFilterLocalLocations.gurye: "구례",
  TagFilterLocalLocations.gwangyang: "광양",
  TagFilterLocalLocations.yeonggwang: "영광",
  TagFilterLocalLocations.jangseong: "장성",
  TagFilterLocalLocations.hampyeong: "함평",
  TagFilterLocalLocations.hwasun: "화순",
  TagFilterLocalLocations.boseong: "보성",
  TagFilterLocalLocations.haenam: "해남",
  TagFilterLocalLocations.wando: "완도",
  TagFilterLocalLocations.gangjin: "강진",
  TagFilterLocalLocations.goheung: "고흥",
  TagFilterLocalLocations.jindo: "진도",
  // 5. 경기
  TagFilterLocalLocations.suwon: "수원",
  TagFilterLocalLocations.anseong: "안성",
  TagFilterLocalLocations.pyeongtaek: "평택",
  TagFilterLocalLocations.songtan: "송탄",
  TagFilterLocalLocations.uijeongbu: "의정부",
  TagFilterLocalLocations.osan: "오산",
  TagFilterLocalLocations.hwaseong: "화성",
  TagFilterLocalLocations.dongtan: "동탄",
  TagFilterLocalLocations.ansan: "안산",
  TagFilterLocalLocations.gimpo: "김포",
  TagFilterLocalLocations.janggi: "장기",
  TagFilterLocalLocations.gurae: "구래",
  TagFilterLocalLocations.daemyunghang: "대면항",
  TagFilterLocalLocations.yongin: "용인",
  TagFilterLocalLocations.goyang: "고양",
  TagFilterLocalLocations.ilsan: "일산",
  TagFilterLocalLocations.seongnam: "성남",
  TagFilterLocalLocations.bundang: "분당",
  TagFilterLocalLocations.anyang: "안양",
  TagFilterLocalLocations.pyeongchon: "평촌",
  TagFilterLocalLocations.indeokwon: "인덕원",
  TagFilterLocalLocations.gwacheon: "과천",
  TagFilterLocalLocations.guri: "구리",
  TagFilterLocalLocations.hanam: "하남",
  TagFilterLocalLocations.gunpo: "군포",
  TagFilterLocalLocations.geumjeong: "금정",
  TagFilterLocalLocations.sanbon: "산본",
  TagFilterLocalLocations.uiwang: "의왕",
  TagFilterLocalLocations.namyangju: "남양주",
  TagFilterLocalLocations.gwangmyeong: "광명",
  TagFilterLocalLocations.cheolsan: "철산",
  TagFilterLocalLocations.siheung: "시흥",
  TagFilterLocalLocations.gapyeong: "가평",
  TagFilterLocalLocations.yangpyeong: "양평",
  TagFilterLocalLocations.wolgok: "월곡",
  TagFilterLocalLocations.jeongwang: "정왕",
  TagFilterLocalLocations.oidoo: "오이도",
  TagFilterLocalLocations.geobukseom: "거북섬",
  TagFilterLocalLocations.pocheon: "포천",
  TagFilterLocalLocations.icheon: "이천",
  TagFilterLocalLocations.gwangju: "광주",
  TagFilterLocalLocations.yeoju: "여주",
  TagFilterLocalLocations.gonjiam: "곤지암",
  TagFilterLocalLocations.yangju: "양주",
  TagFilterLocalLocations.dongducheon: "동두천",
  TagFilterLocalLocations.yeoncheon: "연천",
  TagFilterLocalLocations.jangheung: "장흥",
  // 6. 강원
  TagFilterLocalLocations.gangneung: "강릉",
  TagFilterLocalLocations.yangyang: "양양",
  TagFilterLocalLocations.naksan: "낙산",
  TagFilterLocalLocations.hajodae: "하조대",
  TagFilterLocalLocations.inje: "인제",
  TagFilterLocalLocations.wonju: "원주",
  TagFilterLocalLocations.hoengseong: "횡성",
  TagFilterLocalLocations.sokcho: "속초",
  TagFilterLocalLocations.seorak: "설악",
  TagFilterLocalLocations.gosung: "고성",
  TagFilterLocalLocations.chuncheon: "춘천",
  TagFilterLocalLocations.hongcheon: "홍천",
  TagFilterLocalLocations.cheorwon: "철원",
  TagFilterLocalLocations.hwacheon: "화천",
  TagFilterLocalLocations.pyeongchang: "평창",
  TagFilterLocalLocations.yeongwol: "영월",
  TagFilterLocalLocations.jeongseon: "정선",
  TagFilterLocalLocations.taebaek: "태백",
  TagFilterLocalLocations.jeongdongjin: "정동진",
  TagFilterLocalLocations.donghae: "동해",
  TagFilterLocalLocations.samcheok: "삼척",
  // 7. 충남
  TagFilterLocalLocations.cheonan: "천안",
  TagFilterLocalLocations.sejong: "세종",
  TagFilterLocalLocations.gyeryong: "계룡",
  TagFilterLocalLocations.geumsan: "금산",
  TagFilterLocalLocations.nonsan: "논산",
  TagFilterLocalLocations.gongju: "공주",
  TagFilterLocalLocations.asan: "아산",
  TagFilterLocalLocations.seosan: "서산",
  TagFilterLocalLocations.seochun: "서천",
  TagFilterLocalLocations.buyeo: "부여",
  TagFilterLocalLocations.dangjin: "당진",
  TagFilterLocalLocations.daecheong: "대청",
  TagFilterLocalLocations.boleong: "보령",
  TagFilterLocalLocations.yesan: "예산",
  TagFilterLocalLocations.cheongyang: "청양",
  TagFilterLocalLocations.hongseong: "홍성",
  // 8. 전북
  TagFilterLocalLocations.jeonju: "전주",
  TagFilterLocalLocations.gunsan: "군산",
  TagFilterLocalLocations.bieungdo: "비응도",
  TagFilterLocalLocations.namwon: "남원",
  TagFilterLocalLocations.imsil: "임실",
  TagFilterLocalLocations.sunchang: "순창",
  TagFilterLocalLocations.iksan: "익산",
  TagFilterLocalLocations.muju: "무주",
  TagFilterLocalLocations.jinan: "진안",
  TagFilterLocalLocations.jangsu: "장수",
  TagFilterLocalLocations.gimje: "김제",
  TagFilterLocalLocations.buan: "부안",
  TagFilterLocalLocations.gochang: "고창",
  TagFilterLocalLocations.jeongeup: "정읍",
};

Map<Enum, List<dynamic>> enumMap = {
  // 서울
  TagFilterLocalTabs.seoul: [[TagFilterLocalTabs.seoul]],
  // 경기
  TagFilterLocalTabs.gyeonggi: [
    [TagFilterLocalLocations.suwon],
    [
      TagFilterLocalLocations.anseong,
      TagFilterLocalLocations.pyeongtaek,
      TagFilterLocalLocations.songtan,
    ],
    [
      TagFilterLocalLocations.uijeongbu,
    ],
    [
      TagFilterLocalLocations.osan,
      TagFilterLocalLocations.hwaseong,
      TagFilterLocalLocations.dongtan,
    ],
    [
      TagFilterLocalLocations.ansan,
    ],
    [
      TagFilterLocalLocations.gimpo,
      TagFilterLocalLocations.janggi,
      TagFilterLocalLocations.gurae,
      TagFilterLocalLocations.daemyunghang,
    ],
    [
      TagFilterLocalLocations.yongin
    ],
    [
      TagFilterLocalLocations.goyang,
      TagFilterLocalLocations.ilsan,
    ],
    [
      TagFilterLocalLocations.seongnam,
      TagFilterLocalLocations.bundang,
    ],
    [
      TagFilterLocalLocations.anyang,
      TagFilterLocalLocations.pyeongchon,
      TagFilterLocalLocations.indeokwon,
      TagFilterLocalLocations.gwacheon,
    ],
    [
      TagFilterLocalLocations.guri,
      TagFilterLocalLocations.hanam,
    ],
    [
      TagFilterLocalLocations.gunpo,
      TagFilterLocalLocations.geumjeong,
      TagFilterLocalLocations.sanbon,
      TagFilterLocalLocations.uiwang,
    ],
    [
      TagFilterLocalLocations.namyangju,
    ],
    [
      TagFilterLocalLocations.gwangmyeong,
      TagFilterLocalLocations.cheolsan,
      TagFilterLocalLocations.siheung,
    ],
    [
      TagFilterLocalLocations.gapyeong,
      TagFilterLocalLocations.yangpyeong,
    ],
    [
      TagFilterLocalLocations.wolgok,
      TagFilterLocalLocations.jeongwang,
      TagFilterLocalLocations.oidoo,
      TagFilterLocalLocations.geobukseom,
    ],
    [
      TagFilterLocalLocations.pocheon,
    ],
    [
      TagFilterLocalLocations.icheon,
      TagFilterLocalLocations.gwangju,
      TagFilterLocalLocations.yeoju,
      TagFilterLocalLocations.gonjiam,
    ],
    [
      TagFilterLocalLocations.yangju,
      TagFilterLocalLocations.dongducheon,
      TagFilterLocalLocations.yeoncheon,
      TagFilterLocalLocations.jangheung,
    ],
  ],
  // 인천
  TagFilterLocalTabs.incheon: [[TagFilterLocalLocations.gumi]],
  // 강원
  TagFilterLocalTabs.gangwon : [
    [
      TagFilterLocalLocations.gangneung,
    ],
    [
      TagFilterLocalLocations.yangyang,
      TagFilterLocalLocations.naksan,
      TagFilterLocalLocations.hajodae,
      TagFilterLocalLocations.inje,
    ],
    [
      TagFilterLocalLocations.wonju,
      TagFilterLocalLocations.hoengseong,
    ],
    [
      TagFilterLocalLocations.sokcho,
      TagFilterLocalLocations.seorak,
      TagFilterLocalLocations.gosung,
    ],
    [
      TagFilterLocalLocations.chuncheon,
    ],
    [
      TagFilterLocalLocations.hongcheon,
      TagFilterLocalLocations.cheorwon,
      TagFilterLocalLocations.hwacheon,
    ],
    [
      TagFilterLocalLocations.pyeongchang,
      TagFilterLocalLocations.yeongwol,
      TagFilterLocalLocations.jeongseon,
      TagFilterLocalLocations.taebaek,
    ],
    [
      TagFilterLocalLocations.jeongdongjin,
      TagFilterLocalLocations.donghae,
      TagFilterLocalLocations.samcheok,
    ],
  ],
  // 제주
  TagFilterLocalTabs.jeju : [[TagFilterLocalTabs.jeju]],
  // 부산
  TagFilterLocalTabs.busan : [[TagFilterLocalTabs.busan]],
  // 경남
  TagFilterLocalTabs.gyeongnam : [
    [
      TagFilterLocalLocations.yangsan,
      TagFilterLocalLocations.miryang,
    ],
    [
      TagFilterLocalLocations.gimhae,
      TagFilterLocalLocations.jangyu,
      TagFilterLocalLocations.yulha,
    ],
    [
      TagFilterLocalLocations.jinju
    ],
    [
      TagFilterLocalLocations.geoje,
      TagFilterLocalLocations.tongyeong,
      TagFilterLocalLocations.gosunggun,
    ],
    [TagFilterLocalLocations.changwon],
    [
      TagFilterLocalLocations.sachun,
      TagFilterLocalLocations.namhae,
      TagFilterLocalLocations.hadong,
    ],
    [
      TagFilterLocalLocations.masan,
      TagFilterLocalLocations.jinhae,
    ],
    [
      TagFilterLocalLocations.otherGyeongnam,
    ],
  ],
  // 경북
  TagFilterLocalTabs.gyeongbuk :[
    [
      TagFilterLocalLocations.pohang,
    ],
    [
      TagFilterLocalLocations.gyeongsan,
      TagFilterLocalLocations.hayang,
      TagFilterLocalLocations.yeoncheon,
      TagFilterLocalLocations.chungdo,
    ],
    [
      TagFilterLocalLocations.gyeongju,
    ],
    [
      TagFilterLocalLocations.mungyeong,
      TagFilterLocalLocations.sangju,
      TagFilterLocalLocations.yangju,
      TagFilterLocalLocations.yeoncheon,
    ],
    [
      TagFilterLocalLocations.gumi,
    ],
    [
      TagFilterLocalLocations.gimcheon,
      TagFilterLocalLocations.chilgok,
      TagFilterLocalLocations.waegwan,
      TagFilterLocalLocations.seongju,
      TagFilterLocalLocations.uiseong,
    ],
    [
      TagFilterLocalLocations.andong,
    ],
    [
      TagFilterLocalLocations.uljin,
      TagFilterLocalLocations.ulleungdo,
      TagFilterLocalLocations.cheongsong,
      TagFilterLocalLocations.yeongdeok,
    ],
  ],
  // 충남
  TagFilterLocalTabs.chungnam : [
    [
      TagFilterLocalLocations.cheonan,
      TagFilterLocalLocations.sejong,
    ],
    [
      TagFilterLocalLocations.gyeryong,
      TagFilterLocalLocations.geumsan,
      TagFilterLocalLocations.nonsan,
    ],
    [
      TagFilterLocalLocations.gongju,
      TagFilterLocalLocations.asan,
      TagFilterLocalLocations.seosan,
    ],
    [
      TagFilterLocalLocations.seochun,
      TagFilterLocalLocations.buyeo,
    ],
    [
      TagFilterLocalLocations.dangjin,
      TagFilterLocalLocations.daecheong,
      TagFilterLocalLocations.boleong,
    ],
    [
      TagFilterLocalLocations.yesan,
      TagFilterLocalLocations.cheongyang,
      TagFilterLocalLocations.hongseong,
    ],
  ],
  // 충북
  TagFilterLocalTabs.chungbuk : [
    [
      TagFilterLocalLocations.chungju,
    ],
    [
      TagFilterLocalLocations.jecheon,
      TagFilterLocalLocations.dangyang,
    ],
    [
      TagFilterLocalLocations.jincheon,
      TagFilterLocalLocations.eumseong,
    ],
    [
      TagFilterLocalLocations.chungju,
      TagFilterLocalLocations.suanbo,
    ],
    [
      TagFilterLocalLocations.jeungpyeong,
      TagFilterLocalLocations.goesan,
      TagFilterLocalLocations.yungdong,
      TagFilterLocalLocations.boeun,
      TagFilterLocalLocations.okcheon,
    ],
  ],
  // 전남
  TagFilterLocalTabs.jeonnam : [
    [
      TagFilterLocalLocations.suncheon,
    ],
    [
      TagFilterLocalLocations.mokpo,
      TagFilterLocalLocations.muan,
      TagFilterLocalLocations.yeongam,
    ],
    [
      TagFilterLocalLocations.yeosu,
    ],
    [
      TagFilterLocalLocations.naju,
      TagFilterLocalLocations.damyang,
      TagFilterLocalLocations.gokseong,
      TagFilterLocalLocations.gurye,
    ],
    [
      TagFilterLocalLocations.gwangyang,
    ],
    [
      TagFilterLocalLocations.yeonggwang,
      TagFilterLocalLocations.jangseong,
      TagFilterLocalLocations.hampyeong,
    ],
    [
      TagFilterLocalLocations.hwasun,
      TagFilterLocalLocations.boseong,
      TagFilterLocalLocations.haenam,
      TagFilterLocalLocations.wando,
    ],
    [
      TagFilterLocalLocations.gangjin,
      TagFilterLocalLocations.goheung,
      TagFilterLocalLocations.jindo,
    ],
  ],
  // 전북
  TagFilterLocalTabs.jeonbuk : [
    [
      TagFilterLocalLocations.jeonju,
    ],
    [
      TagFilterLocalLocations.gunsan,
      TagFilterLocalLocations.bieungdo,
    ],
    [
      TagFilterLocalLocations.namwon,
      TagFilterLocalLocations.imsil,
      TagFilterLocalLocations.sunchang,
    ],
    [
      TagFilterLocalLocations.iksan,
    ],
    [
      TagFilterLocalLocations.muju,
      TagFilterLocalLocations.jinan,
      TagFilterLocalLocations.jangsu,
    ],
    [
      TagFilterLocalLocations.gimje,
      TagFilterLocalLocations.buan,
      TagFilterLocalLocations.gochang,
      TagFilterLocalLocations.jeongeup,
    ],
  ],
};