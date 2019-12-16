
_init:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	53                   	push   %ebx
    100e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    100f:	83 ec 08             	sub    $0x8,%esp
    1012:	6a 02                	push   $0x2
    1014:	68 08 18 00 00       	push   $0x1808
    1019:	e8 64 03 00 00       	call   1382 <open>
    101e:	83 c4 10             	add    $0x10,%esp
    1021:	85 c0                	test   %eax,%eax
    1023:	0f 88 9f 00 00 00    	js     10c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
    1029:	83 ec 0c             	sub    $0xc,%esp
    102c:	6a 00                	push   $0x0
    102e:	e8 87 03 00 00       	call   13ba <dup>
  dup(0);  // stderr
    1033:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    103a:	e8 7b 03 00 00       	call   13ba <dup>

  #ifdef FRR
    printf(1, "Scheduler policy: FRR\n");
    103f:	58                   	pop    %eax
    1040:	5a                   	pop    %edx
    1041:	68 10 18 00 00       	push   $0x1810
    1046:	6a 01                	push   $0x1
    1048:	e8 63 04 00 00       	call   14b0 <printf>
    104d:	83 c4 10             	add    $0x10,%esp
  #endif
  #endif
  #endif

  for(;;){
    printf(1, "init: starting sh\n");
    1050:	83 ec 08             	sub    $0x8,%esp
    1053:	68 27 18 00 00       	push   $0x1827
    1058:	6a 01                	push   $0x1
    105a:	e8 51 04 00 00       	call   14b0 <printf>
    pid = fork();
    105f:	e8 d6 02 00 00       	call   133a <fork>
    if(pid < 0){
    1064:	83 c4 10             	add    $0x10,%esp
    1067:	85 c0                	test   %eax,%eax
    pid = fork();
    1069:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    106b:	78 24                	js     1091 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
    106d:	74 35                	je     10a4 <main+0xa4>
    106f:	90                   	nop
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
    1070:	e8 d5 02 00 00       	call   134a <wait>
    1075:	85 c0                	test   %eax,%eax
    1077:	78 d7                	js     1050 <main+0x50>
    1079:	39 c3                	cmp    %eax,%ebx
    107b:	74 d3                	je     1050 <main+0x50>
      printf(1, "zombie!\n");
    107d:	83 ec 08             	sub    $0x8,%esp
    1080:	68 66 18 00 00       	push   $0x1866
    1085:	6a 01                	push   $0x1
    1087:	e8 24 04 00 00       	call   14b0 <printf>
    108c:	83 c4 10             	add    $0x10,%esp
    108f:	eb df                	jmp    1070 <main+0x70>
      printf(1, "init: fork failed\n");
    1091:	53                   	push   %ebx
    1092:	53                   	push   %ebx
    1093:	68 3a 18 00 00       	push   $0x183a
    1098:	6a 01                	push   $0x1
    109a:	e8 11 04 00 00       	call   14b0 <printf>
      exit();
    109f:	e8 9e 02 00 00       	call   1342 <exit>
      exec("sh", argv);
    10a4:	50                   	push   %eax
    10a5:	50                   	push   %eax
    10a6:	68 20 1b 00 00       	push   $0x1b20
    10ab:	68 4d 18 00 00       	push   $0x184d
    10b0:	e8 c5 02 00 00       	call   137a <exec>
      printf(1, "init: exec sh failed\n");
    10b5:	5a                   	pop    %edx
    10b6:	59                   	pop    %ecx
    10b7:	68 50 18 00 00       	push   $0x1850
    10bc:	6a 01                	push   $0x1
    10be:	e8 ed 03 00 00       	call   14b0 <printf>
      exit();
    10c3:	e8 7a 02 00 00       	call   1342 <exit>
    mknod("console", 1, 1);
    10c8:	51                   	push   %ecx
    10c9:	6a 01                	push   $0x1
    10cb:	6a 01                	push   $0x1
    10cd:	68 08 18 00 00       	push   $0x1808
    10d2:	e8 b3 02 00 00       	call   138a <mknod>
    open("console", O_RDWR);
    10d7:	5b                   	pop    %ebx
    10d8:	58                   	pop    %eax
    10d9:	6a 02                	push   $0x2
    10db:	68 08 18 00 00       	push   $0x1808
    10e0:	e8 9d 02 00 00       	call   1382 <open>
    10e5:	83 c4 10             	add    $0x10,%esp
    10e8:	e9 3c ff ff ff       	jmp    1029 <main+0x29>
    10ed:	66 90                	xchg   %ax,%ax
    10ef:	90                   	nop

000010f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	53                   	push   %ebx
    10f4:	8b 45 08             	mov    0x8(%ebp),%eax
    10f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10fa:	89 c2                	mov    %eax,%edx
    10fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1100:	83 c1 01             	add    $0x1,%ecx
    1103:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1107:	83 c2 01             	add    $0x1,%edx
    110a:	84 db                	test   %bl,%bl
    110c:	88 5a ff             	mov    %bl,-0x1(%edx)
    110f:	75 ef                	jne    1100 <strcpy+0x10>
    ;
  return os;
}
    1111:	5b                   	pop    %ebx
    1112:	5d                   	pop    %ebp
    1113:	c3                   	ret    
    1114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    111a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	53                   	push   %ebx
    1124:	8b 55 08             	mov    0x8(%ebp),%edx
    1127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    112a:	0f b6 02             	movzbl (%edx),%eax
    112d:	0f b6 19             	movzbl (%ecx),%ebx
    1130:	84 c0                	test   %al,%al
    1132:	75 1c                	jne    1150 <strcmp+0x30>
    1134:	eb 2a                	jmp    1160 <strcmp+0x40>
    1136:	8d 76 00             	lea    0x0(%esi),%esi
    1139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1140:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1143:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1146:	83 c1 01             	add    $0x1,%ecx
    1149:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    114c:	84 c0                	test   %al,%al
    114e:	74 10                	je     1160 <strcmp+0x40>
    1150:	38 d8                	cmp    %bl,%al
    1152:	74 ec                	je     1140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1154:	29 d8                	sub    %ebx,%eax
}
    1156:	5b                   	pop    %ebx
    1157:	5d                   	pop    %ebp
    1158:	c3                   	ret    
    1159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1160:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1162:	29 d8                	sub    %ebx,%eax
}
    1164:	5b                   	pop    %ebx
    1165:	5d                   	pop    %ebp
    1166:	c3                   	ret    
    1167:	89 f6                	mov    %esi,%esi
    1169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001170 <strlen>:

uint
strlen(const char *s)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1176:	80 39 00             	cmpb   $0x0,(%ecx)
    1179:	74 15                	je     1190 <strlen+0x20>
    117b:	31 d2                	xor    %edx,%edx
    117d:	8d 76 00             	lea    0x0(%esi),%esi
    1180:	83 c2 01             	add    $0x1,%edx
    1183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1187:	89 d0                	mov    %edx,%eax
    1189:	75 f5                	jne    1180 <strlen+0x10>
    ;
  return n;
}
    118b:	5d                   	pop    %ebp
    118c:	c3                   	ret    
    118d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1190:	31 c0                	xor    %eax,%eax
}
    1192:	5d                   	pop    %ebp
    1193:	c3                   	ret    
    1194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    119a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000011a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	57                   	push   %edi
    11a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ad:	89 d7                	mov    %edx,%edi
    11af:	fc                   	cld    
    11b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11b2:	89 d0                	mov    %edx,%eax
    11b4:	5f                   	pop    %edi
    11b5:	5d                   	pop    %ebp
    11b6:	c3                   	ret    
    11b7:	89 f6                	mov    %esi,%esi
    11b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011c0 <strchr>:

char*
strchr(const char *s, char c)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	53                   	push   %ebx
    11c4:	8b 45 08             	mov    0x8(%ebp),%eax
    11c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    11ca:	0f b6 10             	movzbl (%eax),%edx
    11cd:	84 d2                	test   %dl,%dl
    11cf:	74 1d                	je     11ee <strchr+0x2e>
    if(*s == c)
    11d1:	38 d3                	cmp    %dl,%bl
    11d3:	89 d9                	mov    %ebx,%ecx
    11d5:	75 0d                	jne    11e4 <strchr+0x24>
    11d7:	eb 17                	jmp    11f0 <strchr+0x30>
    11d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11e0:	38 ca                	cmp    %cl,%dl
    11e2:	74 0c                	je     11f0 <strchr+0x30>
  for(; *s; s++)
    11e4:	83 c0 01             	add    $0x1,%eax
    11e7:	0f b6 10             	movzbl (%eax),%edx
    11ea:	84 d2                	test   %dl,%dl
    11ec:	75 f2                	jne    11e0 <strchr+0x20>
      return (char*)s;
  return 0;
    11ee:	31 c0                	xor    %eax,%eax
}
    11f0:	5b                   	pop    %ebx
    11f1:	5d                   	pop    %ebp
    11f2:	c3                   	ret    
    11f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001200 <gets>:

char*
gets(char *buf, int max)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	57                   	push   %edi
    1204:	56                   	push   %esi
    1205:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1206:	31 f6                	xor    %esi,%esi
    1208:	89 f3                	mov    %esi,%ebx
{
    120a:	83 ec 1c             	sub    $0x1c,%esp
    120d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1210:	eb 2f                	jmp    1241 <gets+0x41>
    1212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1218:	8d 45 e7             	lea    -0x19(%ebp),%eax
    121b:	83 ec 04             	sub    $0x4,%esp
    121e:	6a 01                	push   $0x1
    1220:	50                   	push   %eax
    1221:	6a 00                	push   $0x0
    1223:	e8 32 01 00 00       	call   135a <read>
    if(cc < 1)
    1228:	83 c4 10             	add    $0x10,%esp
    122b:	85 c0                	test   %eax,%eax
    122d:	7e 1c                	jle    124b <gets+0x4b>
      break;
    buf[i++] = c;
    122f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1233:	83 c7 01             	add    $0x1,%edi
    1236:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1239:	3c 0a                	cmp    $0xa,%al
    123b:	74 23                	je     1260 <gets+0x60>
    123d:	3c 0d                	cmp    $0xd,%al
    123f:	74 1f                	je     1260 <gets+0x60>
  for(i=0; i+1 < max; ){
    1241:	83 c3 01             	add    $0x1,%ebx
    1244:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1247:	89 fe                	mov    %edi,%esi
    1249:	7c cd                	jl     1218 <gets+0x18>
    124b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1250:	c6 03 00             	movb   $0x0,(%ebx)
}
    1253:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1256:	5b                   	pop    %ebx
    1257:	5e                   	pop    %esi
    1258:	5f                   	pop    %edi
    1259:	5d                   	pop    %ebp
    125a:	c3                   	ret    
    125b:	90                   	nop
    125c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1260:	8b 75 08             	mov    0x8(%ebp),%esi
    1263:	8b 45 08             	mov    0x8(%ebp),%eax
    1266:	01 de                	add    %ebx,%esi
    1268:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    126a:	c6 03 00             	movb   $0x0,(%ebx)
}
    126d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1270:	5b                   	pop    %ebx
    1271:	5e                   	pop    %esi
    1272:	5f                   	pop    %edi
    1273:	5d                   	pop    %ebp
    1274:	c3                   	ret    
    1275:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001280 <stat>:

int
stat(const char *n, struct stat *st)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	56                   	push   %esi
    1284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1285:	83 ec 08             	sub    $0x8,%esp
    1288:	6a 00                	push   $0x0
    128a:	ff 75 08             	pushl  0x8(%ebp)
    128d:	e8 f0 00 00 00       	call   1382 <open>
  if(fd < 0)
    1292:	83 c4 10             	add    $0x10,%esp
    1295:	85 c0                	test   %eax,%eax
    1297:	78 27                	js     12c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1299:	83 ec 08             	sub    $0x8,%esp
    129c:	ff 75 0c             	pushl  0xc(%ebp)
    129f:	89 c3                	mov    %eax,%ebx
    12a1:	50                   	push   %eax
    12a2:	e8 f3 00 00 00       	call   139a <fstat>
  close(fd);
    12a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    12aa:	89 c6                	mov    %eax,%esi
  close(fd);
    12ac:	e8 b9 00 00 00       	call   136a <close>
  return r;
    12b1:	83 c4 10             	add    $0x10,%esp
}
    12b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    12b7:	89 f0                	mov    %esi,%eax
    12b9:	5b                   	pop    %ebx
    12ba:	5e                   	pop    %esi
    12bb:	5d                   	pop    %ebp
    12bc:	c3                   	ret    
    12bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    12c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    12c5:	eb ed                	jmp    12b4 <stat+0x34>
    12c7:	89 f6                	mov    %esi,%esi
    12c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012d0 <atoi>:

int
atoi(const char *s)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	53                   	push   %ebx
    12d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12d7:	0f be 11             	movsbl (%ecx),%edx
    12da:	8d 42 d0             	lea    -0x30(%edx),%eax
    12dd:	3c 09                	cmp    $0x9,%al
  n = 0;
    12df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    12e4:	77 1f                	ja     1305 <atoi+0x35>
    12e6:	8d 76 00             	lea    0x0(%esi),%esi
    12e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    12f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    12f3:	83 c1 01             	add    $0x1,%ecx
    12f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    12fa:	0f be 11             	movsbl (%ecx),%edx
    12fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1300:	80 fb 09             	cmp    $0x9,%bl
    1303:	76 eb                	jbe    12f0 <atoi+0x20>
  return n;
}
    1305:	5b                   	pop    %ebx
    1306:	5d                   	pop    %ebp
    1307:	c3                   	ret    
    1308:	90                   	nop
    1309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	56                   	push   %esi
    1314:	53                   	push   %ebx
    1315:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1318:	8b 45 08             	mov    0x8(%ebp),%eax
    131b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    131e:	85 db                	test   %ebx,%ebx
    1320:	7e 14                	jle    1336 <memmove+0x26>
    1322:	31 d2                	xor    %edx,%edx
    1324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1328:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    132c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    132f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    1332:	39 d3                	cmp    %edx,%ebx
    1334:	75 f2                	jne    1328 <memmove+0x18>
  return vdst;
}
    1336:	5b                   	pop    %ebx
    1337:	5e                   	pop    %esi
    1338:	5d                   	pop    %ebp
    1339:	c3                   	ret    

0000133a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    133a:	b8 01 00 00 00       	mov    $0x1,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <exit>:
SYSCALL(exit)
    1342:	b8 02 00 00 00       	mov    $0x2,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <wait>:
SYSCALL(wait)
    134a:	b8 03 00 00 00       	mov    $0x3,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    

00001352 <pipe>:
SYSCALL(pipe)
    1352:	b8 04 00 00 00       	mov    $0x4,%eax
    1357:	cd 40                	int    $0x40
    1359:	c3                   	ret    

0000135a <read>:
SYSCALL(read)
    135a:	b8 05 00 00 00       	mov    $0x5,%eax
    135f:	cd 40                	int    $0x40
    1361:	c3                   	ret    

00001362 <write>:
SYSCALL(write)
    1362:	b8 10 00 00 00       	mov    $0x10,%eax
    1367:	cd 40                	int    $0x40
    1369:	c3                   	ret    

0000136a <close>:
SYSCALL(close)
    136a:	b8 15 00 00 00       	mov    $0x15,%eax
    136f:	cd 40                	int    $0x40
    1371:	c3                   	ret    

00001372 <kill>:
SYSCALL(kill)
    1372:	b8 06 00 00 00       	mov    $0x6,%eax
    1377:	cd 40                	int    $0x40
    1379:	c3                   	ret    

0000137a <exec>:
SYSCALL(exec)
    137a:	b8 07 00 00 00       	mov    $0x7,%eax
    137f:	cd 40                	int    $0x40
    1381:	c3                   	ret    

00001382 <open>:
SYSCALL(open)
    1382:	b8 0f 00 00 00       	mov    $0xf,%eax
    1387:	cd 40                	int    $0x40
    1389:	c3                   	ret    

0000138a <mknod>:
SYSCALL(mknod)
    138a:	b8 11 00 00 00       	mov    $0x11,%eax
    138f:	cd 40                	int    $0x40
    1391:	c3                   	ret    

00001392 <unlink>:
SYSCALL(unlink)
    1392:	b8 12 00 00 00       	mov    $0x12,%eax
    1397:	cd 40                	int    $0x40
    1399:	c3                   	ret    

0000139a <fstat>:
SYSCALL(fstat)
    139a:	b8 08 00 00 00       	mov    $0x8,%eax
    139f:	cd 40                	int    $0x40
    13a1:	c3                   	ret    

000013a2 <link>:
SYSCALL(link)
    13a2:	b8 13 00 00 00       	mov    $0x13,%eax
    13a7:	cd 40                	int    $0x40
    13a9:	c3                   	ret    

000013aa <mkdir>:
SYSCALL(mkdir)
    13aa:	b8 14 00 00 00       	mov    $0x14,%eax
    13af:	cd 40                	int    $0x40
    13b1:	c3                   	ret    

000013b2 <chdir>:
SYSCALL(chdir)
    13b2:	b8 09 00 00 00       	mov    $0x9,%eax
    13b7:	cd 40                	int    $0x40
    13b9:	c3                   	ret    

000013ba <dup>:
SYSCALL(dup)
    13ba:	b8 0a 00 00 00       	mov    $0xa,%eax
    13bf:	cd 40                	int    $0x40
    13c1:	c3                   	ret    

000013c2 <getpid>:
SYSCALL(getpid)
    13c2:	b8 0b 00 00 00       	mov    $0xb,%eax
    13c7:	cd 40                	int    $0x40
    13c9:	c3                   	ret    

000013ca <sbrk>:
SYSCALL(sbrk)
    13ca:	b8 0c 00 00 00       	mov    $0xc,%eax
    13cf:	cd 40                	int    $0x40
    13d1:	c3                   	ret    

000013d2 <sleep>:
SYSCALL(sleep)
    13d2:	b8 0d 00 00 00       	mov    $0xd,%eax
    13d7:	cd 40                	int    $0x40
    13d9:	c3                   	ret    

000013da <uptime>:
SYSCALL(uptime)
    13da:	b8 0e 00 00 00       	mov    $0xe,%eax
    13df:	cd 40                	int    $0x40
    13e1:	c3                   	ret    

000013e2 <getyear>:
SYSCALL(getyear)
    13e2:	b8 16 00 00 00       	mov    $0x16,%eax
    13e7:	cd 40                	int    $0x40
    13e9:	c3                   	ret    

000013ea <runtime>:
SYSCALL(runtime)
    13ea:	b8 17 00 00 00       	mov    $0x17,%eax
    13ef:	cd 40                	int    $0x40
    13f1:	c3                   	ret    

000013f2 <waittime>:
SYSCALL(waittime)
    13f2:	b8 18 00 00 00       	mov    $0x18,%eax
    13f7:	cd 40                	int    $0x40
    13f9:	c3                   	ret    

000013fa <turntime>:
SYSCALL(turntime)
    13fa:	b8 19 00 00 00       	mov    $0x19,%eax
    13ff:	cd 40                	int    $0x40
    1401:	c3                   	ret    
    1402:	66 90                	xchg   %ax,%ax
    1404:	66 90                	xchg   %ax,%ax
    1406:	66 90                	xchg   %ax,%ax
    1408:	66 90                	xchg   %ax,%ax
    140a:	66 90                	xchg   %ax,%ax
    140c:	66 90                	xchg   %ax,%ax
    140e:	66 90                	xchg   %ax,%ax

00001410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	57                   	push   %edi
    1414:	56                   	push   %esi
    1415:	53                   	push   %ebx
    1416:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1419:	85 d2                	test   %edx,%edx
{
    141b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    141e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1420:	79 76                	jns    1498 <printint+0x88>
    1422:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    1426:	74 70                	je     1498 <printint+0x88>
    x = -xx;
    1428:	f7 d8                	neg    %eax
    neg = 1;
    142a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1431:	31 f6                	xor    %esi,%esi
    1433:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1436:	eb 0a                	jmp    1442 <printint+0x32>
    1438:	90                   	nop
    1439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    1440:	89 fe                	mov    %edi,%esi
    1442:	31 d2                	xor    %edx,%edx
    1444:	8d 7e 01             	lea    0x1(%esi),%edi
    1447:	f7 f1                	div    %ecx
    1449:	0f b6 92 78 18 00 00 	movzbl 0x1878(%edx),%edx
  }while((x /= base) != 0);
    1450:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1452:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1455:	75 e9                	jne    1440 <printint+0x30>
  if(neg)
    1457:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    145a:	85 c0                	test   %eax,%eax
    145c:	74 08                	je     1466 <printint+0x56>
    buf[i++] = '-';
    145e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1463:	8d 7e 02             	lea    0x2(%esi),%edi
    1466:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    146a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    146d:	8d 76 00             	lea    0x0(%esi),%esi
    1470:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    1473:	83 ec 04             	sub    $0x4,%esp
    1476:	83 ee 01             	sub    $0x1,%esi
    1479:	6a 01                	push   $0x1
    147b:	53                   	push   %ebx
    147c:	57                   	push   %edi
    147d:	88 45 d7             	mov    %al,-0x29(%ebp)
    1480:	e8 dd fe ff ff       	call   1362 <write>

  while(--i >= 0)
    1485:	83 c4 10             	add    $0x10,%esp
    1488:	39 de                	cmp    %ebx,%esi
    148a:	75 e4                	jne    1470 <printint+0x60>
    putc(fd, buf[i]);
}
    148c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    148f:	5b                   	pop    %ebx
    1490:	5e                   	pop    %esi
    1491:	5f                   	pop    %edi
    1492:	5d                   	pop    %ebp
    1493:	c3                   	ret    
    1494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1498:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    149f:	eb 90                	jmp    1431 <printint+0x21>
    14a1:	eb 0d                	jmp    14b0 <printf>
    14a3:	90                   	nop
    14a4:	90                   	nop
    14a5:	90                   	nop
    14a6:	90                   	nop
    14a7:	90                   	nop
    14a8:	90                   	nop
    14a9:	90                   	nop
    14aa:	90                   	nop
    14ab:	90                   	nop
    14ac:	90                   	nop
    14ad:	90                   	nop
    14ae:	90                   	nop
    14af:	90                   	nop

000014b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    14b0:	55                   	push   %ebp
    14b1:	89 e5                	mov    %esp,%ebp
    14b3:	57                   	push   %edi
    14b4:	56                   	push   %esi
    14b5:	53                   	push   %ebx
    14b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14b9:	8b 75 0c             	mov    0xc(%ebp),%esi
    14bc:	0f b6 1e             	movzbl (%esi),%ebx
    14bf:	84 db                	test   %bl,%bl
    14c1:	0f 84 b3 00 00 00    	je     157a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    14c7:	8d 45 10             	lea    0x10(%ebp),%eax
    14ca:	83 c6 01             	add    $0x1,%esi
  state = 0;
    14cd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    14cf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    14d2:	eb 2f                	jmp    1503 <printf+0x53>
    14d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    14d8:	83 f8 25             	cmp    $0x25,%eax
    14db:	0f 84 a7 00 00 00    	je     1588 <printf+0xd8>
  write(fd, &c, 1);
    14e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    14e4:	83 ec 04             	sub    $0x4,%esp
    14e7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    14ea:	6a 01                	push   $0x1
    14ec:	50                   	push   %eax
    14ed:	ff 75 08             	pushl  0x8(%ebp)
    14f0:	e8 6d fe ff ff       	call   1362 <write>
    14f5:	83 c4 10             	add    $0x10,%esp
    14f8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    14fb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    14ff:	84 db                	test   %bl,%bl
    1501:	74 77                	je     157a <printf+0xca>
    if(state == 0){
    1503:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1505:	0f be cb             	movsbl %bl,%ecx
    1508:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    150b:	74 cb                	je     14d8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    150d:	83 ff 25             	cmp    $0x25,%edi
    1510:	75 e6                	jne    14f8 <printf+0x48>
      if(c == 'd'){
    1512:	83 f8 64             	cmp    $0x64,%eax
    1515:	0f 84 05 01 00 00    	je     1620 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    151b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1521:	83 f9 70             	cmp    $0x70,%ecx
    1524:	74 72                	je     1598 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1526:	83 f8 73             	cmp    $0x73,%eax
    1529:	0f 84 99 00 00 00    	je     15c8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    152f:	83 f8 63             	cmp    $0x63,%eax
    1532:	0f 84 08 01 00 00    	je     1640 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1538:	83 f8 25             	cmp    $0x25,%eax
    153b:	0f 84 ef 00 00 00    	je     1630 <printf+0x180>
  write(fd, &c, 1);
    1541:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1544:	83 ec 04             	sub    $0x4,%esp
    1547:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    154b:	6a 01                	push   $0x1
    154d:	50                   	push   %eax
    154e:	ff 75 08             	pushl  0x8(%ebp)
    1551:	e8 0c fe ff ff       	call   1362 <write>
    1556:	83 c4 0c             	add    $0xc,%esp
    1559:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    155c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    155f:	6a 01                	push   $0x1
    1561:	50                   	push   %eax
    1562:	ff 75 08             	pushl  0x8(%ebp)
    1565:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1568:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    156a:	e8 f3 fd ff ff       	call   1362 <write>
  for(i = 0; fmt[i]; i++){
    156f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    1573:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1576:	84 db                	test   %bl,%bl
    1578:	75 89                	jne    1503 <printf+0x53>
    }
  }
}
    157a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    157d:	5b                   	pop    %ebx
    157e:	5e                   	pop    %esi
    157f:	5f                   	pop    %edi
    1580:	5d                   	pop    %ebp
    1581:	c3                   	ret    
    1582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    1588:	bf 25 00 00 00       	mov    $0x25,%edi
    158d:	e9 66 ff ff ff       	jmp    14f8 <printf+0x48>
    1592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1598:	83 ec 0c             	sub    $0xc,%esp
    159b:	b9 10 00 00 00       	mov    $0x10,%ecx
    15a0:	6a 00                	push   $0x0
    15a2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    15a5:	8b 45 08             	mov    0x8(%ebp),%eax
    15a8:	8b 17                	mov    (%edi),%edx
    15aa:	e8 61 fe ff ff       	call   1410 <printint>
        ap++;
    15af:	89 f8                	mov    %edi,%eax
    15b1:	83 c4 10             	add    $0x10,%esp
      state = 0;
    15b4:	31 ff                	xor    %edi,%edi
        ap++;
    15b6:	83 c0 04             	add    $0x4,%eax
    15b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    15bc:	e9 37 ff ff ff       	jmp    14f8 <printf+0x48>
    15c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    15c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    15cb:	8b 08                	mov    (%eax),%ecx
        ap++;
    15cd:	83 c0 04             	add    $0x4,%eax
    15d0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    15d3:	85 c9                	test   %ecx,%ecx
    15d5:	0f 84 8e 00 00 00    	je     1669 <printf+0x1b9>
        while(*s != 0){
    15db:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    15de:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    15e0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    15e2:	84 c0                	test   %al,%al
    15e4:	0f 84 0e ff ff ff    	je     14f8 <printf+0x48>
    15ea:	89 75 d0             	mov    %esi,-0x30(%ebp)
    15ed:	89 de                	mov    %ebx,%esi
    15ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
    15f2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    15f5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    15f8:	83 ec 04             	sub    $0x4,%esp
          s++;
    15fb:	83 c6 01             	add    $0x1,%esi
    15fe:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1601:	6a 01                	push   $0x1
    1603:	57                   	push   %edi
    1604:	53                   	push   %ebx
    1605:	e8 58 fd ff ff       	call   1362 <write>
        while(*s != 0){
    160a:	0f b6 06             	movzbl (%esi),%eax
    160d:	83 c4 10             	add    $0x10,%esp
    1610:	84 c0                	test   %al,%al
    1612:	75 e4                	jne    15f8 <printf+0x148>
    1614:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1617:	31 ff                	xor    %edi,%edi
    1619:	e9 da fe ff ff       	jmp    14f8 <printf+0x48>
    161e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1620:	83 ec 0c             	sub    $0xc,%esp
    1623:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1628:	6a 01                	push   $0x1
    162a:	e9 73 ff ff ff       	jmp    15a2 <printf+0xf2>
    162f:	90                   	nop
  write(fd, &c, 1);
    1630:	83 ec 04             	sub    $0x4,%esp
    1633:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1636:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1639:	6a 01                	push   $0x1
    163b:	e9 21 ff ff ff       	jmp    1561 <printf+0xb1>
        putc(fd, *ap);
    1640:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1643:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1646:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1648:	6a 01                	push   $0x1
        ap++;
    164a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    164d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1650:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1653:	50                   	push   %eax
    1654:	ff 75 08             	pushl  0x8(%ebp)
    1657:	e8 06 fd ff ff       	call   1362 <write>
        ap++;
    165c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    165f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1662:	31 ff                	xor    %edi,%edi
    1664:	e9 8f fe ff ff       	jmp    14f8 <printf+0x48>
          s = "(null)";
    1669:	bb 6f 18 00 00       	mov    $0x186f,%ebx
        while(*s != 0){
    166e:	b8 28 00 00 00       	mov    $0x28,%eax
    1673:	e9 72 ff ff ff       	jmp    15ea <printf+0x13a>
    1678:	66 90                	xchg   %ax,%ax
    167a:	66 90                	xchg   %ax,%ax
    167c:	66 90                	xchg   %ax,%ax
    167e:	66 90                	xchg   %ax,%ax

00001680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1681:	a1 28 1b 00 00       	mov    0x1b28,%eax
{
    1686:	89 e5                	mov    %esp,%ebp
    1688:	57                   	push   %edi
    1689:	56                   	push   %esi
    168a:	53                   	push   %ebx
    168b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    168e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1698:	39 c8                	cmp    %ecx,%eax
    169a:	8b 10                	mov    (%eax),%edx
    169c:	73 32                	jae    16d0 <free+0x50>
    169e:	39 d1                	cmp    %edx,%ecx
    16a0:	72 04                	jb     16a6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16a2:	39 d0                	cmp    %edx,%eax
    16a4:	72 32                	jb     16d8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    16a6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16a9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16ac:	39 fa                	cmp    %edi,%edx
    16ae:	74 30                	je     16e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    16b0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    16b3:	8b 50 04             	mov    0x4(%eax),%edx
    16b6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    16b9:	39 f1                	cmp    %esi,%ecx
    16bb:	74 3a                	je     16f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    16bd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    16bf:	a3 28 1b 00 00       	mov    %eax,0x1b28
}
    16c4:	5b                   	pop    %ebx
    16c5:	5e                   	pop    %esi
    16c6:	5f                   	pop    %edi
    16c7:	5d                   	pop    %ebp
    16c8:	c3                   	ret    
    16c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16d0:	39 d0                	cmp    %edx,%eax
    16d2:	72 04                	jb     16d8 <free+0x58>
    16d4:	39 d1                	cmp    %edx,%ecx
    16d6:	72 ce                	jb     16a6 <free+0x26>
{
    16d8:	89 d0                	mov    %edx,%eax
    16da:	eb bc                	jmp    1698 <free+0x18>
    16dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    16e0:	03 72 04             	add    0x4(%edx),%esi
    16e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    16e6:	8b 10                	mov    (%eax),%edx
    16e8:	8b 12                	mov    (%edx),%edx
    16ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    16ed:	8b 50 04             	mov    0x4(%eax),%edx
    16f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    16f3:	39 f1                	cmp    %esi,%ecx
    16f5:	75 c6                	jne    16bd <free+0x3d>
    p->s.size += bp->s.size;
    16f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    16fa:	a3 28 1b 00 00       	mov    %eax,0x1b28
    p->s.size += bp->s.size;
    16ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1702:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1705:	89 10                	mov    %edx,(%eax)
}
    1707:	5b                   	pop    %ebx
    1708:	5e                   	pop    %esi
    1709:	5f                   	pop    %edi
    170a:	5d                   	pop    %ebp
    170b:	c3                   	ret    
    170c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1710:	55                   	push   %ebp
    1711:	89 e5                	mov    %esp,%ebp
    1713:	57                   	push   %edi
    1714:	56                   	push   %esi
    1715:	53                   	push   %ebx
    1716:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1719:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    171c:	8b 15 28 1b 00 00    	mov    0x1b28,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1722:	8d 78 07             	lea    0x7(%eax),%edi
    1725:	c1 ef 03             	shr    $0x3,%edi
    1728:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    172b:	85 d2                	test   %edx,%edx
    172d:	0f 84 9d 00 00 00    	je     17d0 <malloc+0xc0>
    1733:	8b 02                	mov    (%edx),%eax
    1735:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1738:	39 cf                	cmp    %ecx,%edi
    173a:	76 6c                	jbe    17a8 <malloc+0x98>
    173c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1742:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1747:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    174a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1751:	eb 0e                	jmp    1761 <malloc+0x51>
    1753:	90                   	nop
    1754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1758:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    175a:	8b 48 04             	mov    0x4(%eax),%ecx
    175d:	39 f9                	cmp    %edi,%ecx
    175f:	73 47                	jae    17a8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1761:	39 05 28 1b 00 00    	cmp    %eax,0x1b28
    1767:	89 c2                	mov    %eax,%edx
    1769:	75 ed                	jne    1758 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    176b:	83 ec 0c             	sub    $0xc,%esp
    176e:	56                   	push   %esi
    176f:	e8 56 fc ff ff       	call   13ca <sbrk>
  if(p == (char*)-1)
    1774:	83 c4 10             	add    $0x10,%esp
    1777:	83 f8 ff             	cmp    $0xffffffff,%eax
    177a:	74 1c                	je     1798 <malloc+0x88>
  hp->s.size = nu;
    177c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    177f:	83 ec 0c             	sub    $0xc,%esp
    1782:	83 c0 08             	add    $0x8,%eax
    1785:	50                   	push   %eax
    1786:	e8 f5 fe ff ff       	call   1680 <free>
  return freep;
    178b:	8b 15 28 1b 00 00    	mov    0x1b28,%edx
      if((p = morecore(nunits)) == 0)
    1791:	83 c4 10             	add    $0x10,%esp
    1794:	85 d2                	test   %edx,%edx
    1796:	75 c0                	jne    1758 <malloc+0x48>
        return 0;
  }
}
    1798:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    179b:	31 c0                	xor    %eax,%eax
}
    179d:	5b                   	pop    %ebx
    179e:	5e                   	pop    %esi
    179f:	5f                   	pop    %edi
    17a0:	5d                   	pop    %ebp
    17a1:	c3                   	ret    
    17a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    17a8:	39 cf                	cmp    %ecx,%edi
    17aa:	74 54                	je     1800 <malloc+0xf0>
        p->s.size -= nunits;
    17ac:	29 f9                	sub    %edi,%ecx
    17ae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    17b1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    17b4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    17b7:	89 15 28 1b 00 00    	mov    %edx,0x1b28
}
    17bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    17c0:	83 c0 08             	add    $0x8,%eax
}
    17c3:	5b                   	pop    %ebx
    17c4:	5e                   	pop    %esi
    17c5:	5f                   	pop    %edi
    17c6:	5d                   	pop    %ebp
    17c7:	c3                   	ret    
    17c8:	90                   	nop
    17c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    17d0:	c7 05 28 1b 00 00 2c 	movl   $0x1b2c,0x1b28
    17d7:	1b 00 00 
    17da:	c7 05 2c 1b 00 00 2c 	movl   $0x1b2c,0x1b2c
    17e1:	1b 00 00 
    base.s.size = 0;
    17e4:	b8 2c 1b 00 00       	mov    $0x1b2c,%eax
    17e9:	c7 05 30 1b 00 00 00 	movl   $0x0,0x1b30
    17f0:	00 00 00 
    17f3:	e9 44 ff ff ff       	jmp    173c <malloc+0x2c>
    17f8:	90                   	nop
    17f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1800:	8b 08                	mov    (%eax),%ecx
    1802:	89 0a                	mov    %ecx,(%edx)
    1804:	eb b1                	jmp    17b7 <malloc+0xa7>
