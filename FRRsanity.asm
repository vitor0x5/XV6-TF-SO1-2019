
_FRRsanity:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(void){
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	57                   	push   %edi
    100e:	56                   	push   %esi
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	be 0a 00 00 00       	mov    $0xa,%esi
    1016:	83 ec 18             	sub    $0x18,%esp
    1019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    int i, j;
    int pid, tt, wt, rt;
    
    for(i = 0; i < 10; i++){
        if(fork() == 0){    //SE filho imprime
    1020:	e8 f5 02 00 00       	call   131a <fork>
    1025:	85 c0                	test   %eax,%eax
    1027:	89 c3                	mov    %eax,%ebx
    1029:	74 75                	je     10a0 <main+0xa0>
    for(i = 0; i < 10; i++){
    102b:	83 ee 01             	sub    $0x1,%esi
    102e:	75 f0                	jne    1020 <main+0x20>
    1030:	bb 0a 00 00 00       	mov    $0xa,%ebx
    1035:	8d 76 00             	lea    0x0(%esi),%esi
            return 0;  //Finaliza execução do processo filho
        }
    }

    for(i = 0; i < 10; i++)
        wait(); //pai esperando execução dos filhos
    1038:	e8 ed 02 00 00       	call   132a <wait>
    for(i = 0; i < 10; i++)
    103d:	83 eb 01             	sub    $0x1,%ebx
    1040:	75 f6                	jne    1038 <main+0x38>

    //imprime os tempos de execução e espera dos  filhos
    for(i = 1; i < 11; i++){
    1042:	bb 01 00 00 00       	mov    $0x1,%ebx
    1047:	89 f6                	mov    %esi,%esi
    1049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        pid = getpid();
    1050:	e8 4d 03 00 00       	call   13a2 <getpid>
    1055:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        rt = runtime();
    1058:	e8 6d 03 00 00       	call   13ca <runtime>
    105d:	89 c7                	mov    %eax,%edi
        wt = waittime();
    105f:	e8 6e 03 00 00       	call   13d2 <waittime>
    1064:	89 c6                	mov    %eax,%esi
        tt = turntime();
    1066:	e8 6f 03 00 00       	call   13da <turntime>
        printf(1, "Child %d: running time = %d, waiting time = %d, turnaround time = %d\n",
    106b:	83 ec 08             	sub    $0x8,%esp
    106e:	50                   	push   %eax
    106f:	56                   	push   %esi
    1070:	8b 75 e4             	mov    -0x1c(%ebp),%esi
    1073:	57                   	push   %edi
    1074:	01 de                	add    %ebx,%esi
    for(i = 1; i < 11; i++){
    1076:	83 c3 01             	add    $0x1,%ebx
        printf(1, "Child %d: running time = %d, waiting time = %d, turnaround time = %d\n",
    1079:	56                   	push   %esi
    107a:	68 0c 18 00 00       	push   $0x180c
    107f:	6a 01                	push   $0x1
    1081:	e8 0a 04 00 00       	call   1490 <printf>
    for(i = 1; i < 11; i++){
    1086:	83 c4 20             	add    $0x20,%esp
    1089:	83 fb 0b             	cmp    $0xb,%ebx
    108c:	75 c2                	jne    1050 <main+0x50>
            pid+i, rt, wt, tt);
    }
    return 0;
    108e:	8d 65 f0             	lea    -0x10(%ebp),%esp
    1091:	31 c0                	xor    %eax,%eax
    1093:	59                   	pop    %ecx
    1094:	5b                   	pop    %ebx
    1095:	5e                   	pop    %esi
    1096:	5f                   	pop    %edi
    1097:	5d                   	pop    %ebp
    1098:	8d 61 fc             	lea    -0x4(%ecx),%esp
    109b:	c3                   	ret    
    109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                printf(1, "child %d prints for the %d time\n", getpid(), j+1);
    10a0:	83 c3 01             	add    $0x1,%ebx
    10a3:	e8 fa 02 00 00       	call   13a2 <getpid>
    10a8:	53                   	push   %ebx
    10a9:	50                   	push   %eax
    10aa:	68 e8 17 00 00       	push   $0x17e8
    10af:	6a 01                	push   $0x1
    10b1:	e8 da 03 00 00       	call   1490 <printf>
            for(j = 0; j < 1000; j++){
    10b6:	83 c4 10             	add    $0x10,%esp
    10b9:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    10bf:	75 df                	jne    10a0 <main+0xa0>
    10c1:	eb cb                	jmp    108e <main+0x8e>
    10c3:	66 90                	xchg   %ax,%ax
    10c5:	66 90                	xchg   %ax,%ax
    10c7:	66 90                	xchg   %ax,%ax
    10c9:	66 90                	xchg   %ax,%ax
    10cb:	66 90                	xchg   %ax,%ax
    10cd:	66 90                	xchg   %ax,%ax
    10cf:	90                   	nop

000010d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	53                   	push   %ebx
    10d4:	8b 45 08             	mov    0x8(%ebp),%eax
    10d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10da:	89 c2                	mov    %eax,%edx
    10dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10e0:	83 c1 01             	add    $0x1,%ecx
    10e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    10e7:	83 c2 01             	add    $0x1,%edx
    10ea:	84 db                	test   %bl,%bl
    10ec:	88 5a ff             	mov    %bl,-0x1(%edx)
    10ef:	75 ef                	jne    10e0 <strcpy+0x10>
    ;
  return os;
}
    10f1:	5b                   	pop    %ebx
    10f2:	5d                   	pop    %ebp
    10f3:	c3                   	ret    
    10f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001100 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	53                   	push   %ebx
    1104:	8b 55 08             	mov    0x8(%ebp),%edx
    1107:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    110a:	0f b6 02             	movzbl (%edx),%eax
    110d:	0f b6 19             	movzbl (%ecx),%ebx
    1110:	84 c0                	test   %al,%al
    1112:	75 1c                	jne    1130 <strcmp+0x30>
    1114:	eb 2a                	jmp    1140 <strcmp+0x40>
    1116:	8d 76 00             	lea    0x0(%esi),%esi
    1119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1120:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1123:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1126:	83 c1 01             	add    $0x1,%ecx
    1129:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    112c:	84 c0                	test   %al,%al
    112e:	74 10                	je     1140 <strcmp+0x40>
    1130:	38 d8                	cmp    %bl,%al
    1132:	74 ec                	je     1120 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1134:	29 d8                	sub    %ebx,%eax
}
    1136:	5b                   	pop    %ebx
    1137:	5d                   	pop    %ebp
    1138:	c3                   	ret    
    1139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1140:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1142:	29 d8                	sub    %ebx,%eax
}
    1144:	5b                   	pop    %ebx
    1145:	5d                   	pop    %ebp
    1146:	c3                   	ret    
    1147:	89 f6                	mov    %esi,%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001150 <strlen>:

uint
strlen(const char *s)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1156:	80 39 00             	cmpb   $0x0,(%ecx)
    1159:	74 15                	je     1170 <strlen+0x20>
    115b:	31 d2                	xor    %edx,%edx
    115d:	8d 76 00             	lea    0x0(%esi),%esi
    1160:	83 c2 01             	add    $0x1,%edx
    1163:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1167:	89 d0                	mov    %edx,%eax
    1169:	75 f5                	jne    1160 <strlen+0x10>
    ;
  return n;
}
    116b:	5d                   	pop    %ebp
    116c:	c3                   	ret    
    116d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1170:	31 c0                	xor    %eax,%eax
}
    1172:	5d                   	pop    %ebp
    1173:	c3                   	ret    
    1174:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    117a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001180 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	57                   	push   %edi
    1184:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1187:	8b 4d 10             	mov    0x10(%ebp),%ecx
    118a:	8b 45 0c             	mov    0xc(%ebp),%eax
    118d:	89 d7                	mov    %edx,%edi
    118f:	fc                   	cld    
    1190:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1192:	89 d0                	mov    %edx,%eax
    1194:	5f                   	pop    %edi
    1195:	5d                   	pop    %ebp
    1196:	c3                   	ret    
    1197:	89 f6                	mov    %esi,%esi
    1199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011a0 <strchr>:

char*
strchr(const char *s, char c)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	53                   	push   %ebx
    11a4:	8b 45 08             	mov    0x8(%ebp),%eax
    11a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    11aa:	0f b6 10             	movzbl (%eax),%edx
    11ad:	84 d2                	test   %dl,%dl
    11af:	74 1d                	je     11ce <strchr+0x2e>
    if(*s == c)
    11b1:	38 d3                	cmp    %dl,%bl
    11b3:	89 d9                	mov    %ebx,%ecx
    11b5:	75 0d                	jne    11c4 <strchr+0x24>
    11b7:	eb 17                	jmp    11d0 <strchr+0x30>
    11b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11c0:	38 ca                	cmp    %cl,%dl
    11c2:	74 0c                	je     11d0 <strchr+0x30>
  for(; *s; s++)
    11c4:	83 c0 01             	add    $0x1,%eax
    11c7:	0f b6 10             	movzbl (%eax),%edx
    11ca:	84 d2                	test   %dl,%dl
    11cc:	75 f2                	jne    11c0 <strchr+0x20>
      return (char*)s;
  return 0;
    11ce:	31 c0                	xor    %eax,%eax
}
    11d0:	5b                   	pop    %ebx
    11d1:	5d                   	pop    %ebp
    11d2:	c3                   	ret    
    11d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011e0 <gets>:

char*
gets(char *buf, int max)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	57                   	push   %edi
    11e4:	56                   	push   %esi
    11e5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11e6:	31 f6                	xor    %esi,%esi
    11e8:	89 f3                	mov    %esi,%ebx
{
    11ea:	83 ec 1c             	sub    $0x1c,%esp
    11ed:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    11f0:	eb 2f                	jmp    1221 <gets+0x41>
    11f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    11f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11fb:	83 ec 04             	sub    $0x4,%esp
    11fe:	6a 01                	push   $0x1
    1200:	50                   	push   %eax
    1201:	6a 00                	push   $0x0
    1203:	e8 32 01 00 00       	call   133a <read>
    if(cc < 1)
    1208:	83 c4 10             	add    $0x10,%esp
    120b:	85 c0                	test   %eax,%eax
    120d:	7e 1c                	jle    122b <gets+0x4b>
      break;
    buf[i++] = c;
    120f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1213:	83 c7 01             	add    $0x1,%edi
    1216:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1219:	3c 0a                	cmp    $0xa,%al
    121b:	74 23                	je     1240 <gets+0x60>
    121d:	3c 0d                	cmp    $0xd,%al
    121f:	74 1f                	je     1240 <gets+0x60>
  for(i=0; i+1 < max; ){
    1221:	83 c3 01             	add    $0x1,%ebx
    1224:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1227:	89 fe                	mov    %edi,%esi
    1229:	7c cd                	jl     11f8 <gets+0x18>
    122b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    122d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1230:	c6 03 00             	movb   $0x0,(%ebx)
}
    1233:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1236:	5b                   	pop    %ebx
    1237:	5e                   	pop    %esi
    1238:	5f                   	pop    %edi
    1239:	5d                   	pop    %ebp
    123a:	c3                   	ret    
    123b:	90                   	nop
    123c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1240:	8b 75 08             	mov    0x8(%ebp),%esi
    1243:	8b 45 08             	mov    0x8(%ebp),%eax
    1246:	01 de                	add    %ebx,%esi
    1248:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    124a:	c6 03 00             	movb   $0x0,(%ebx)
}
    124d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1250:	5b                   	pop    %ebx
    1251:	5e                   	pop    %esi
    1252:	5f                   	pop    %edi
    1253:	5d                   	pop    %ebp
    1254:	c3                   	ret    
    1255:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001260 <stat>:

int
stat(const char *n, struct stat *st)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	56                   	push   %esi
    1264:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1265:	83 ec 08             	sub    $0x8,%esp
    1268:	6a 00                	push   $0x0
    126a:	ff 75 08             	pushl  0x8(%ebp)
    126d:	e8 f0 00 00 00       	call   1362 <open>
  if(fd < 0)
    1272:	83 c4 10             	add    $0x10,%esp
    1275:	85 c0                	test   %eax,%eax
    1277:	78 27                	js     12a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1279:	83 ec 08             	sub    $0x8,%esp
    127c:	ff 75 0c             	pushl  0xc(%ebp)
    127f:	89 c3                	mov    %eax,%ebx
    1281:	50                   	push   %eax
    1282:	e8 f3 00 00 00       	call   137a <fstat>
  close(fd);
    1287:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    128a:	89 c6                	mov    %eax,%esi
  close(fd);
    128c:	e8 b9 00 00 00       	call   134a <close>
  return r;
    1291:	83 c4 10             	add    $0x10,%esp
}
    1294:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1297:	89 f0                	mov    %esi,%eax
    1299:	5b                   	pop    %ebx
    129a:	5e                   	pop    %esi
    129b:	5d                   	pop    %ebp
    129c:	c3                   	ret    
    129d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    12a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    12a5:	eb ed                	jmp    1294 <stat+0x34>
    12a7:	89 f6                	mov    %esi,%esi
    12a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012b0 <atoi>:

int
atoi(const char *s)
{
    12b0:	55                   	push   %ebp
    12b1:	89 e5                	mov    %esp,%ebp
    12b3:	53                   	push   %ebx
    12b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12b7:	0f be 11             	movsbl (%ecx),%edx
    12ba:	8d 42 d0             	lea    -0x30(%edx),%eax
    12bd:	3c 09                	cmp    $0x9,%al
  n = 0;
    12bf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    12c4:	77 1f                	ja     12e5 <atoi+0x35>
    12c6:	8d 76 00             	lea    0x0(%esi),%esi
    12c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    12d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    12d3:	83 c1 01             	add    $0x1,%ecx
    12d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    12da:	0f be 11             	movsbl (%ecx),%edx
    12dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    12e0:	80 fb 09             	cmp    $0x9,%bl
    12e3:	76 eb                	jbe    12d0 <atoi+0x20>
  return n;
}
    12e5:	5b                   	pop    %ebx
    12e6:	5d                   	pop    %ebp
    12e7:	c3                   	ret    
    12e8:	90                   	nop
    12e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000012f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	56                   	push   %esi
    12f4:	53                   	push   %ebx
    12f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12f8:	8b 45 08             	mov    0x8(%ebp),%eax
    12fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12fe:	85 db                	test   %ebx,%ebx
    1300:	7e 14                	jle    1316 <memmove+0x26>
    1302:	31 d2                	xor    %edx,%edx
    1304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1308:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    130c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    130f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    1312:	39 d3                	cmp    %edx,%ebx
    1314:	75 f2                	jne    1308 <memmove+0x18>
  return vdst;
}
    1316:	5b                   	pop    %ebx
    1317:	5e                   	pop    %esi
    1318:	5d                   	pop    %ebp
    1319:	c3                   	ret    

0000131a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    131a:	b8 01 00 00 00       	mov    $0x1,%eax
    131f:	cd 40                	int    $0x40
    1321:	c3                   	ret    

00001322 <exit>:
SYSCALL(exit)
    1322:	b8 02 00 00 00       	mov    $0x2,%eax
    1327:	cd 40                	int    $0x40
    1329:	c3                   	ret    

0000132a <wait>:
SYSCALL(wait)
    132a:	b8 03 00 00 00       	mov    $0x3,%eax
    132f:	cd 40                	int    $0x40
    1331:	c3                   	ret    

00001332 <pipe>:
SYSCALL(pipe)
    1332:	b8 04 00 00 00       	mov    $0x4,%eax
    1337:	cd 40                	int    $0x40
    1339:	c3                   	ret    

0000133a <read>:
SYSCALL(read)
    133a:	b8 05 00 00 00       	mov    $0x5,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <write>:
SYSCALL(write)
    1342:	b8 10 00 00 00       	mov    $0x10,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <close>:
SYSCALL(close)
    134a:	b8 15 00 00 00       	mov    $0x15,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    

00001352 <kill>:
SYSCALL(kill)
    1352:	b8 06 00 00 00       	mov    $0x6,%eax
    1357:	cd 40                	int    $0x40
    1359:	c3                   	ret    

0000135a <exec>:
SYSCALL(exec)
    135a:	b8 07 00 00 00       	mov    $0x7,%eax
    135f:	cd 40                	int    $0x40
    1361:	c3                   	ret    

00001362 <open>:
SYSCALL(open)
    1362:	b8 0f 00 00 00       	mov    $0xf,%eax
    1367:	cd 40                	int    $0x40
    1369:	c3                   	ret    

0000136a <mknod>:
SYSCALL(mknod)
    136a:	b8 11 00 00 00       	mov    $0x11,%eax
    136f:	cd 40                	int    $0x40
    1371:	c3                   	ret    

00001372 <unlink>:
SYSCALL(unlink)
    1372:	b8 12 00 00 00       	mov    $0x12,%eax
    1377:	cd 40                	int    $0x40
    1379:	c3                   	ret    

0000137a <fstat>:
SYSCALL(fstat)
    137a:	b8 08 00 00 00       	mov    $0x8,%eax
    137f:	cd 40                	int    $0x40
    1381:	c3                   	ret    

00001382 <link>:
SYSCALL(link)
    1382:	b8 13 00 00 00       	mov    $0x13,%eax
    1387:	cd 40                	int    $0x40
    1389:	c3                   	ret    

0000138a <mkdir>:
SYSCALL(mkdir)
    138a:	b8 14 00 00 00       	mov    $0x14,%eax
    138f:	cd 40                	int    $0x40
    1391:	c3                   	ret    

00001392 <chdir>:
SYSCALL(chdir)
    1392:	b8 09 00 00 00       	mov    $0x9,%eax
    1397:	cd 40                	int    $0x40
    1399:	c3                   	ret    

0000139a <dup>:
SYSCALL(dup)
    139a:	b8 0a 00 00 00       	mov    $0xa,%eax
    139f:	cd 40                	int    $0x40
    13a1:	c3                   	ret    

000013a2 <getpid>:
SYSCALL(getpid)
    13a2:	b8 0b 00 00 00       	mov    $0xb,%eax
    13a7:	cd 40                	int    $0x40
    13a9:	c3                   	ret    

000013aa <sbrk>:
SYSCALL(sbrk)
    13aa:	b8 0c 00 00 00       	mov    $0xc,%eax
    13af:	cd 40                	int    $0x40
    13b1:	c3                   	ret    

000013b2 <sleep>:
SYSCALL(sleep)
    13b2:	b8 0d 00 00 00       	mov    $0xd,%eax
    13b7:	cd 40                	int    $0x40
    13b9:	c3                   	ret    

000013ba <uptime>:
SYSCALL(uptime)
    13ba:	b8 0e 00 00 00       	mov    $0xe,%eax
    13bf:	cd 40                	int    $0x40
    13c1:	c3                   	ret    

000013c2 <getyear>:
SYSCALL(getyear)
    13c2:	b8 16 00 00 00       	mov    $0x16,%eax
    13c7:	cd 40                	int    $0x40
    13c9:	c3                   	ret    

000013ca <runtime>:
SYSCALL(runtime)
    13ca:	b8 17 00 00 00       	mov    $0x17,%eax
    13cf:	cd 40                	int    $0x40
    13d1:	c3                   	ret    

000013d2 <waittime>:
SYSCALL(waittime)
    13d2:	b8 18 00 00 00       	mov    $0x18,%eax
    13d7:	cd 40                	int    $0x40
    13d9:	c3                   	ret    

000013da <turntime>:
SYSCALL(turntime)
    13da:	b8 19 00 00 00       	mov    $0x19,%eax
    13df:	cd 40                	int    $0x40
    13e1:	c3                   	ret    
    13e2:	66 90                	xchg   %ax,%ax
    13e4:	66 90                	xchg   %ax,%ax
    13e6:	66 90                	xchg   %ax,%ax
    13e8:	66 90                	xchg   %ax,%ax
    13ea:	66 90                	xchg   %ax,%ax
    13ec:	66 90                	xchg   %ax,%ax
    13ee:	66 90                	xchg   %ax,%ax

000013f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	57                   	push   %edi
    13f4:	56                   	push   %esi
    13f5:	53                   	push   %ebx
    13f6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13f9:	85 d2                	test   %edx,%edx
{
    13fb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    13fe:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1400:	79 76                	jns    1478 <printint+0x88>
    1402:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    1406:	74 70                	je     1478 <printint+0x88>
    x = -xx;
    1408:	f7 d8                	neg    %eax
    neg = 1;
    140a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1411:	31 f6                	xor    %esi,%esi
    1413:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1416:	eb 0a                	jmp    1422 <printint+0x32>
    1418:	90                   	nop
    1419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    1420:	89 fe                	mov    %edi,%esi
    1422:	31 d2                	xor    %edx,%edx
    1424:	8d 7e 01             	lea    0x1(%esi),%edi
    1427:	f7 f1                	div    %ecx
    1429:	0f b6 92 5c 18 00 00 	movzbl 0x185c(%edx),%edx
  }while((x /= base) != 0);
    1430:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1432:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1435:	75 e9                	jne    1420 <printint+0x30>
  if(neg)
    1437:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    143a:	85 c0                	test   %eax,%eax
    143c:	74 08                	je     1446 <printint+0x56>
    buf[i++] = '-';
    143e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1443:	8d 7e 02             	lea    0x2(%esi),%edi
    1446:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    144a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    144d:	8d 76 00             	lea    0x0(%esi),%esi
    1450:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    1453:	83 ec 04             	sub    $0x4,%esp
    1456:	83 ee 01             	sub    $0x1,%esi
    1459:	6a 01                	push   $0x1
    145b:	53                   	push   %ebx
    145c:	57                   	push   %edi
    145d:	88 45 d7             	mov    %al,-0x29(%ebp)
    1460:	e8 dd fe ff ff       	call   1342 <write>

  while(--i >= 0)
    1465:	83 c4 10             	add    $0x10,%esp
    1468:	39 de                	cmp    %ebx,%esi
    146a:	75 e4                	jne    1450 <printint+0x60>
    putc(fd, buf[i]);
}
    146c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    146f:	5b                   	pop    %ebx
    1470:	5e                   	pop    %esi
    1471:	5f                   	pop    %edi
    1472:	5d                   	pop    %ebp
    1473:	c3                   	ret    
    1474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1478:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    147f:	eb 90                	jmp    1411 <printint+0x21>
    1481:	eb 0d                	jmp    1490 <printf>
    1483:	90                   	nop
    1484:	90                   	nop
    1485:	90                   	nop
    1486:	90                   	nop
    1487:	90                   	nop
    1488:	90                   	nop
    1489:	90                   	nop
    148a:	90                   	nop
    148b:	90                   	nop
    148c:	90                   	nop
    148d:	90                   	nop
    148e:	90                   	nop
    148f:	90                   	nop

00001490 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1490:	55                   	push   %ebp
    1491:	89 e5                	mov    %esp,%ebp
    1493:	57                   	push   %edi
    1494:	56                   	push   %esi
    1495:	53                   	push   %ebx
    1496:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1499:	8b 75 0c             	mov    0xc(%ebp),%esi
    149c:	0f b6 1e             	movzbl (%esi),%ebx
    149f:	84 db                	test   %bl,%bl
    14a1:	0f 84 b3 00 00 00    	je     155a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    14a7:	8d 45 10             	lea    0x10(%ebp),%eax
    14aa:	83 c6 01             	add    $0x1,%esi
  state = 0;
    14ad:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    14af:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    14b2:	eb 2f                	jmp    14e3 <printf+0x53>
    14b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    14b8:	83 f8 25             	cmp    $0x25,%eax
    14bb:	0f 84 a7 00 00 00    	je     1568 <printf+0xd8>
  write(fd, &c, 1);
    14c1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    14c4:	83 ec 04             	sub    $0x4,%esp
    14c7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    14ca:	6a 01                	push   $0x1
    14cc:	50                   	push   %eax
    14cd:	ff 75 08             	pushl  0x8(%ebp)
    14d0:	e8 6d fe ff ff       	call   1342 <write>
    14d5:	83 c4 10             	add    $0x10,%esp
    14d8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    14db:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    14df:	84 db                	test   %bl,%bl
    14e1:	74 77                	je     155a <printf+0xca>
    if(state == 0){
    14e3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    14e5:	0f be cb             	movsbl %bl,%ecx
    14e8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    14eb:	74 cb                	je     14b8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    14ed:	83 ff 25             	cmp    $0x25,%edi
    14f0:	75 e6                	jne    14d8 <printf+0x48>
      if(c == 'd'){
    14f2:	83 f8 64             	cmp    $0x64,%eax
    14f5:	0f 84 05 01 00 00    	je     1600 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    14fb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1501:	83 f9 70             	cmp    $0x70,%ecx
    1504:	74 72                	je     1578 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1506:	83 f8 73             	cmp    $0x73,%eax
    1509:	0f 84 99 00 00 00    	je     15a8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    150f:	83 f8 63             	cmp    $0x63,%eax
    1512:	0f 84 08 01 00 00    	je     1620 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1518:	83 f8 25             	cmp    $0x25,%eax
    151b:	0f 84 ef 00 00 00    	je     1610 <printf+0x180>
  write(fd, &c, 1);
    1521:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1524:	83 ec 04             	sub    $0x4,%esp
    1527:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    152b:	6a 01                	push   $0x1
    152d:	50                   	push   %eax
    152e:	ff 75 08             	pushl  0x8(%ebp)
    1531:	e8 0c fe ff ff       	call   1342 <write>
    1536:	83 c4 0c             	add    $0xc,%esp
    1539:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    153c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    153f:	6a 01                	push   $0x1
    1541:	50                   	push   %eax
    1542:	ff 75 08             	pushl  0x8(%ebp)
    1545:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1548:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    154a:	e8 f3 fd ff ff       	call   1342 <write>
  for(i = 0; fmt[i]; i++){
    154f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    1553:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1556:	84 db                	test   %bl,%bl
    1558:	75 89                	jne    14e3 <printf+0x53>
    }
  }
}
    155a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    155d:	5b                   	pop    %ebx
    155e:	5e                   	pop    %esi
    155f:	5f                   	pop    %edi
    1560:	5d                   	pop    %ebp
    1561:	c3                   	ret    
    1562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    1568:	bf 25 00 00 00       	mov    $0x25,%edi
    156d:	e9 66 ff ff ff       	jmp    14d8 <printf+0x48>
    1572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1578:	83 ec 0c             	sub    $0xc,%esp
    157b:	b9 10 00 00 00       	mov    $0x10,%ecx
    1580:	6a 00                	push   $0x0
    1582:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    1585:	8b 45 08             	mov    0x8(%ebp),%eax
    1588:	8b 17                	mov    (%edi),%edx
    158a:	e8 61 fe ff ff       	call   13f0 <printint>
        ap++;
    158f:	89 f8                	mov    %edi,%eax
    1591:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1594:	31 ff                	xor    %edi,%edi
        ap++;
    1596:	83 c0 04             	add    $0x4,%eax
    1599:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    159c:	e9 37 ff ff ff       	jmp    14d8 <printf+0x48>
    15a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    15a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    15ab:	8b 08                	mov    (%eax),%ecx
        ap++;
    15ad:	83 c0 04             	add    $0x4,%eax
    15b0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    15b3:	85 c9                	test   %ecx,%ecx
    15b5:	0f 84 8e 00 00 00    	je     1649 <printf+0x1b9>
        while(*s != 0){
    15bb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    15be:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    15c0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    15c2:	84 c0                	test   %al,%al
    15c4:	0f 84 0e ff ff ff    	je     14d8 <printf+0x48>
    15ca:	89 75 d0             	mov    %esi,-0x30(%ebp)
    15cd:	89 de                	mov    %ebx,%esi
    15cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
    15d2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    15d5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    15d8:	83 ec 04             	sub    $0x4,%esp
          s++;
    15db:	83 c6 01             	add    $0x1,%esi
    15de:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    15e1:	6a 01                	push   $0x1
    15e3:	57                   	push   %edi
    15e4:	53                   	push   %ebx
    15e5:	e8 58 fd ff ff       	call   1342 <write>
        while(*s != 0){
    15ea:	0f b6 06             	movzbl (%esi),%eax
    15ed:	83 c4 10             	add    $0x10,%esp
    15f0:	84 c0                	test   %al,%al
    15f2:	75 e4                	jne    15d8 <printf+0x148>
    15f4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    15f7:	31 ff                	xor    %edi,%edi
    15f9:	e9 da fe ff ff       	jmp    14d8 <printf+0x48>
    15fe:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1600:	83 ec 0c             	sub    $0xc,%esp
    1603:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1608:	6a 01                	push   $0x1
    160a:	e9 73 ff ff ff       	jmp    1582 <printf+0xf2>
    160f:	90                   	nop
  write(fd, &c, 1);
    1610:	83 ec 04             	sub    $0x4,%esp
    1613:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1616:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1619:	6a 01                	push   $0x1
    161b:	e9 21 ff ff ff       	jmp    1541 <printf+0xb1>
        putc(fd, *ap);
    1620:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1623:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1626:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1628:	6a 01                	push   $0x1
        ap++;
    162a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    162d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1630:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1633:	50                   	push   %eax
    1634:	ff 75 08             	pushl  0x8(%ebp)
    1637:	e8 06 fd ff ff       	call   1342 <write>
        ap++;
    163c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    163f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1642:	31 ff                	xor    %edi,%edi
    1644:	e9 8f fe ff ff       	jmp    14d8 <printf+0x48>
          s = "(null)";
    1649:	bb 54 18 00 00       	mov    $0x1854,%ebx
        while(*s != 0){
    164e:	b8 28 00 00 00       	mov    $0x28,%eax
    1653:	e9 72 ff ff ff       	jmp    15ca <printf+0x13a>
    1658:	66 90                	xchg   %ax,%ax
    165a:	66 90                	xchg   %ax,%ax
    165c:	66 90                	xchg   %ax,%ax
    165e:	66 90                	xchg   %ax,%ax

00001660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1661:	a1 24 1b 00 00       	mov    0x1b24,%eax
{
    1666:	89 e5                	mov    %esp,%ebp
    1668:	57                   	push   %edi
    1669:	56                   	push   %esi
    166a:	53                   	push   %ebx
    166b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    166e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1678:	39 c8                	cmp    %ecx,%eax
    167a:	8b 10                	mov    (%eax),%edx
    167c:	73 32                	jae    16b0 <free+0x50>
    167e:	39 d1                	cmp    %edx,%ecx
    1680:	72 04                	jb     1686 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1682:	39 d0                	cmp    %edx,%eax
    1684:	72 32                	jb     16b8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1686:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1689:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    168c:	39 fa                	cmp    %edi,%edx
    168e:	74 30                	je     16c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1690:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1693:	8b 50 04             	mov    0x4(%eax),%edx
    1696:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1699:	39 f1                	cmp    %esi,%ecx
    169b:	74 3a                	je     16d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    169d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    169f:	a3 24 1b 00 00       	mov    %eax,0x1b24
}
    16a4:	5b                   	pop    %ebx
    16a5:	5e                   	pop    %esi
    16a6:	5f                   	pop    %edi
    16a7:	5d                   	pop    %ebp
    16a8:	c3                   	ret    
    16a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16b0:	39 d0                	cmp    %edx,%eax
    16b2:	72 04                	jb     16b8 <free+0x58>
    16b4:	39 d1                	cmp    %edx,%ecx
    16b6:	72 ce                	jb     1686 <free+0x26>
{
    16b8:	89 d0                	mov    %edx,%eax
    16ba:	eb bc                	jmp    1678 <free+0x18>
    16bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    16c0:	03 72 04             	add    0x4(%edx),%esi
    16c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    16c6:	8b 10                	mov    (%eax),%edx
    16c8:	8b 12                	mov    (%edx),%edx
    16ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    16cd:	8b 50 04             	mov    0x4(%eax),%edx
    16d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    16d3:	39 f1                	cmp    %esi,%ecx
    16d5:	75 c6                	jne    169d <free+0x3d>
    p->s.size += bp->s.size;
    16d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    16da:	a3 24 1b 00 00       	mov    %eax,0x1b24
    p->s.size += bp->s.size;
    16df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16e2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    16e5:	89 10                	mov    %edx,(%eax)
}
    16e7:	5b                   	pop    %ebx
    16e8:	5e                   	pop    %esi
    16e9:	5f                   	pop    %edi
    16ea:	5d                   	pop    %ebp
    16eb:	c3                   	ret    
    16ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000016f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    16f0:	55                   	push   %ebp
    16f1:	89 e5                	mov    %esp,%ebp
    16f3:	57                   	push   %edi
    16f4:	56                   	push   %esi
    16f5:	53                   	push   %ebx
    16f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    16fc:	8b 15 24 1b 00 00    	mov    0x1b24,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1702:	8d 78 07             	lea    0x7(%eax),%edi
    1705:	c1 ef 03             	shr    $0x3,%edi
    1708:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    170b:	85 d2                	test   %edx,%edx
    170d:	0f 84 9d 00 00 00    	je     17b0 <malloc+0xc0>
    1713:	8b 02                	mov    (%edx),%eax
    1715:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1718:	39 cf                	cmp    %ecx,%edi
    171a:	76 6c                	jbe    1788 <malloc+0x98>
    171c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1722:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1727:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    172a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1731:	eb 0e                	jmp    1741 <malloc+0x51>
    1733:	90                   	nop
    1734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1738:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    173a:	8b 48 04             	mov    0x4(%eax),%ecx
    173d:	39 f9                	cmp    %edi,%ecx
    173f:	73 47                	jae    1788 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1741:	39 05 24 1b 00 00    	cmp    %eax,0x1b24
    1747:	89 c2                	mov    %eax,%edx
    1749:	75 ed                	jne    1738 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    174b:	83 ec 0c             	sub    $0xc,%esp
    174e:	56                   	push   %esi
    174f:	e8 56 fc ff ff       	call   13aa <sbrk>
  if(p == (char*)-1)
    1754:	83 c4 10             	add    $0x10,%esp
    1757:	83 f8 ff             	cmp    $0xffffffff,%eax
    175a:	74 1c                	je     1778 <malloc+0x88>
  hp->s.size = nu;
    175c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    175f:	83 ec 0c             	sub    $0xc,%esp
    1762:	83 c0 08             	add    $0x8,%eax
    1765:	50                   	push   %eax
    1766:	e8 f5 fe ff ff       	call   1660 <free>
  return freep;
    176b:	8b 15 24 1b 00 00    	mov    0x1b24,%edx
      if((p = morecore(nunits)) == 0)
    1771:	83 c4 10             	add    $0x10,%esp
    1774:	85 d2                	test   %edx,%edx
    1776:	75 c0                	jne    1738 <malloc+0x48>
        return 0;
  }
}
    1778:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    177b:	31 c0                	xor    %eax,%eax
}
    177d:	5b                   	pop    %ebx
    177e:	5e                   	pop    %esi
    177f:	5f                   	pop    %edi
    1780:	5d                   	pop    %ebp
    1781:	c3                   	ret    
    1782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1788:	39 cf                	cmp    %ecx,%edi
    178a:	74 54                	je     17e0 <malloc+0xf0>
        p->s.size -= nunits;
    178c:	29 f9                	sub    %edi,%ecx
    178e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1791:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1794:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1797:	89 15 24 1b 00 00    	mov    %edx,0x1b24
}
    179d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    17a0:	83 c0 08             	add    $0x8,%eax
}
    17a3:	5b                   	pop    %ebx
    17a4:	5e                   	pop    %esi
    17a5:	5f                   	pop    %edi
    17a6:	5d                   	pop    %ebp
    17a7:	c3                   	ret    
    17a8:	90                   	nop
    17a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    17b0:	c7 05 24 1b 00 00 28 	movl   $0x1b28,0x1b24
    17b7:	1b 00 00 
    17ba:	c7 05 28 1b 00 00 28 	movl   $0x1b28,0x1b28
    17c1:	1b 00 00 
    base.s.size = 0;
    17c4:	b8 28 1b 00 00       	mov    $0x1b28,%eax
    17c9:	c7 05 2c 1b 00 00 00 	movl   $0x0,0x1b2c
    17d0:	00 00 00 
    17d3:	e9 44 ff ff ff       	jmp    171c <malloc+0x2c>
    17d8:	90                   	nop
    17d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    17e0:	8b 08                	mov    (%eax),%ecx
    17e2:	89 0a                	mov    %ecx,(%edx)
    17e4:	eb b1                	jmp    1797 <malloc+0xa7>
