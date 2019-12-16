
_ls:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	56                   	push   %esi
    100e:	53                   	push   %ebx
    100f:	51                   	push   %ecx
    1010:	83 ec 0c             	sub    $0xc,%esp
    1013:	8b 01                	mov    (%ecx),%eax
    1015:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  if(argc < 2){
    1018:	83 f8 01             	cmp    $0x1,%eax
    101b:	7e 24                	jle    1041 <main+0x41>
    101d:	8d 5a 04             	lea    0x4(%edx),%ebx
    1020:	8d 34 82             	lea    (%edx,%eax,4),%esi
    1023:	90                   	nop
    1024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
    1028:	83 ec 0c             	sub    $0xc,%esp
    102b:	ff 33                	pushl  (%ebx)
    102d:	83 c3 04             	add    $0x4,%ebx
    1030:	e8 cb 00 00 00       	call   1100 <ls>
  for(i=1; i<argc; i++)
    1035:	83 c4 10             	add    $0x10,%esp
    1038:	39 f3                	cmp    %esi,%ebx
    103a:	75 ec                	jne    1028 <main+0x28>
  exit();
    103c:	e8 41 05 00 00       	call   1582 <exit>
    ls(".");
    1041:	83 ec 0c             	sub    $0xc,%esp
    1044:	68 90 1a 00 00       	push   $0x1a90
    1049:	e8 b2 00 00 00       	call   1100 <ls>
    exit();
    104e:	e8 2f 05 00 00       	call   1582 <exit>
    1053:	66 90                	xchg   %ax,%ax
    1055:	66 90                	xchg   %ax,%ax
    1057:	66 90                	xchg   %ax,%ax
    1059:	66 90                	xchg   %ax,%ax
    105b:	66 90                	xchg   %ax,%ax
    105d:	66 90                	xchg   %ax,%ax
    105f:	90                   	nop

00001060 <fmtname>:
{
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	56                   	push   %esi
    1064:	53                   	push   %ebx
    1065:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    1068:	83 ec 0c             	sub    $0xc,%esp
    106b:	53                   	push   %ebx
    106c:	e8 3f 03 00 00       	call   13b0 <strlen>
    1071:	83 c4 10             	add    $0x10,%esp
    1074:	01 d8                	add    %ebx,%eax
    1076:	73 0f                	jae    1087 <fmtname+0x27>
    1078:	eb 12                	jmp    108c <fmtname+0x2c>
    107a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1080:	83 e8 01             	sub    $0x1,%eax
    1083:	39 c3                	cmp    %eax,%ebx
    1085:	77 05                	ja     108c <fmtname+0x2c>
    1087:	80 38 2f             	cmpb   $0x2f,(%eax)
    108a:	75 f4                	jne    1080 <fmtname+0x20>
  p++;
    108c:	8d 58 01             	lea    0x1(%eax),%ebx
  if(strlen(p) >= DIRSIZ)
    108f:	83 ec 0c             	sub    $0xc,%esp
    1092:	53                   	push   %ebx
    1093:	e8 18 03 00 00       	call   13b0 <strlen>
    1098:	83 c4 10             	add    $0x10,%esp
    109b:	83 f8 0d             	cmp    $0xd,%eax
    109e:	77 4a                	ja     10ea <fmtname+0x8a>
  memmove(buf, p, strlen(p));
    10a0:	83 ec 0c             	sub    $0xc,%esp
    10a3:	53                   	push   %ebx
    10a4:	e8 07 03 00 00       	call   13b0 <strlen>
    10a9:	83 c4 0c             	add    $0xc,%esp
    10ac:	50                   	push   %eax
    10ad:	53                   	push   %ebx
    10ae:	68 bc 1d 00 00       	push   $0x1dbc
    10b3:	e8 98 04 00 00       	call   1550 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    10b8:	89 1c 24             	mov    %ebx,(%esp)
    10bb:	e8 f0 02 00 00       	call   13b0 <strlen>
    10c0:	89 1c 24             	mov    %ebx,(%esp)
    10c3:	89 c6                	mov    %eax,%esi
  return buf;
    10c5:	bb bc 1d 00 00       	mov    $0x1dbc,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    10ca:	e8 e1 02 00 00       	call   13b0 <strlen>
    10cf:	ba 0e 00 00 00       	mov    $0xe,%edx
    10d4:	83 c4 0c             	add    $0xc,%esp
    10d7:	05 bc 1d 00 00       	add    $0x1dbc,%eax
    10dc:	29 f2                	sub    %esi,%edx
    10de:	52                   	push   %edx
    10df:	6a 20                	push   $0x20
    10e1:	50                   	push   %eax
    10e2:	e8 f9 02 00 00       	call   13e0 <memset>
  return buf;
    10e7:	83 c4 10             	add    $0x10,%esp
}
    10ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
    10ed:	89 d8                	mov    %ebx,%eax
    10ef:	5b                   	pop    %ebx
    10f0:	5e                   	pop    %esi
    10f1:	5d                   	pop    %ebp
    10f2:	c3                   	ret    
    10f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001100 <ls>:
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	57                   	push   %edi
    1104:	56                   	push   %esi
    1105:	53                   	push   %ebx
    1106:	81 ec 64 02 00 00    	sub    $0x264,%esp
    110c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
    110f:	6a 00                	push   $0x0
    1111:	57                   	push   %edi
    1112:	e8 ab 04 00 00       	call   15c2 <open>
    1117:	83 c4 10             	add    $0x10,%esp
    111a:	85 c0                	test   %eax,%eax
    111c:	78 52                	js     1170 <ls+0x70>
  if(fstat(fd, &st) < 0){
    111e:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
    1124:	83 ec 08             	sub    $0x8,%esp
    1127:	89 c3                	mov    %eax,%ebx
    1129:	56                   	push   %esi
    112a:	50                   	push   %eax
    112b:	e8 aa 04 00 00       	call   15da <fstat>
    1130:	83 c4 10             	add    $0x10,%esp
    1133:	85 c0                	test   %eax,%eax
    1135:	0f 88 c5 00 00 00    	js     1200 <ls+0x100>
  switch(st.type){
    113b:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
    1142:	66 83 f8 01          	cmp    $0x1,%ax
    1146:	0f 84 84 00 00 00    	je     11d0 <ls+0xd0>
    114c:	66 83 f8 02          	cmp    $0x2,%ax
    1150:	74 3e                	je     1190 <ls+0x90>
  close(fd);
    1152:	83 ec 0c             	sub    $0xc,%esp
    1155:	53                   	push   %ebx
    1156:	e8 4f 04 00 00       	call   15aa <close>
    115b:	83 c4 10             	add    $0x10,%esp
}
    115e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1161:	5b                   	pop    %ebx
    1162:	5e                   	pop    %esi
    1163:	5f                   	pop    %edi
    1164:	5d                   	pop    %ebp
    1165:	c3                   	ret    
    1166:	8d 76 00             	lea    0x0(%esi),%esi
    1169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "ls: cannot open %s\n", path);
    1170:	83 ec 04             	sub    $0x4,%esp
    1173:	57                   	push   %edi
    1174:	68 48 1a 00 00       	push   $0x1a48
    1179:	6a 02                	push   $0x2
    117b:	e8 70 05 00 00       	call   16f0 <printf>
    return;
    1180:	83 c4 10             	add    $0x10,%esp
}
    1183:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1186:	5b                   	pop    %ebx
    1187:	5e                   	pop    %esi
    1188:	5f                   	pop    %edi
    1189:	5d                   	pop    %ebp
    118a:	c3                   	ret    
    118b:	90                   	nop
    118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    1190:	83 ec 0c             	sub    $0xc,%esp
    1193:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
    1199:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
    119f:	57                   	push   %edi
    11a0:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
    11a6:	e8 b5 fe ff ff       	call   1060 <fmtname>
    11ab:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
    11b1:	59                   	pop    %ecx
    11b2:	5f                   	pop    %edi
    11b3:	52                   	push   %edx
    11b4:	56                   	push   %esi
    11b5:	6a 02                	push   $0x2
    11b7:	50                   	push   %eax
    11b8:	68 70 1a 00 00       	push   $0x1a70
    11bd:	6a 01                	push   $0x1
    11bf:	e8 2c 05 00 00       	call   16f0 <printf>
    break;
    11c4:	83 c4 20             	add    $0x20,%esp
    11c7:	eb 89                	jmp    1152 <ls+0x52>
    11c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
    11d0:	83 ec 0c             	sub    $0xc,%esp
    11d3:	57                   	push   %edi
    11d4:	e8 d7 01 00 00       	call   13b0 <strlen>
    11d9:	83 c0 10             	add    $0x10,%eax
    11dc:	83 c4 10             	add    $0x10,%esp
    11df:	3d 00 02 00 00       	cmp    $0x200,%eax
    11e4:	76 42                	jbe    1228 <ls+0x128>
      printf(1, "ls: path too long\n");
    11e6:	83 ec 08             	sub    $0x8,%esp
    11e9:	68 7d 1a 00 00       	push   $0x1a7d
    11ee:	6a 01                	push   $0x1
    11f0:	e8 fb 04 00 00       	call   16f0 <printf>
      break;
    11f5:	83 c4 10             	add    $0x10,%esp
    11f8:	e9 55 ff ff ff       	jmp    1152 <ls+0x52>
    11fd:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot stat %s\n", path);
    1200:	83 ec 04             	sub    $0x4,%esp
    1203:	57                   	push   %edi
    1204:	68 5c 1a 00 00       	push   $0x1a5c
    1209:	6a 02                	push   $0x2
    120b:	e8 e0 04 00 00       	call   16f0 <printf>
    close(fd);
    1210:	89 1c 24             	mov    %ebx,(%esp)
    1213:	e8 92 03 00 00       	call   15aa <close>
    return;
    1218:	83 c4 10             	add    $0x10,%esp
}
    121b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    121e:	5b                   	pop    %ebx
    121f:	5e                   	pop    %esi
    1220:	5f                   	pop    %edi
    1221:	5d                   	pop    %ebp
    1222:	c3                   	ret    
    1223:	90                   	nop
    1224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    strcpy(buf, path);
    1228:	83 ec 08             	sub    $0x8,%esp
    122b:	57                   	push   %edi
    122c:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
    1232:	57                   	push   %edi
    1233:	e8 f8 00 00 00       	call   1330 <strcpy>
    p = buf+strlen(buf);
    1238:	89 3c 24             	mov    %edi,(%esp)
    123b:	e8 70 01 00 00       	call   13b0 <strlen>
    1240:	01 f8                	add    %edi,%eax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    1242:	83 c4 10             	add    $0x10,%esp
    *p++ = '/';
    1245:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
    1248:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
    124e:	c6 00 2f             	movb   $0x2f,(%eax)
    1251:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
    1257:	89 f6                	mov    %esi,%esi
    1259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    1260:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
    1266:	83 ec 04             	sub    $0x4,%esp
    1269:	6a 10                	push   $0x10
    126b:	50                   	push   %eax
    126c:	53                   	push   %ebx
    126d:	e8 28 03 00 00       	call   159a <read>
    1272:	83 c4 10             	add    $0x10,%esp
    1275:	83 f8 10             	cmp    $0x10,%eax
    1278:	0f 85 d4 fe ff ff    	jne    1152 <ls+0x52>
      if(de.inum == 0)
    127e:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
    1285:	00 
    1286:	74 d8                	je     1260 <ls+0x160>
      memmove(p, de.name, DIRSIZ);
    1288:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
    128e:	83 ec 04             	sub    $0x4,%esp
    1291:	6a 0e                	push   $0xe
    1293:	50                   	push   %eax
    1294:	ff b5 a4 fd ff ff    	pushl  -0x25c(%ebp)
    129a:	e8 b1 02 00 00       	call   1550 <memmove>
      p[DIRSIZ] = 0;
    129f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
    12a5:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
    12a9:	58                   	pop    %eax
    12aa:	5a                   	pop    %edx
    12ab:	56                   	push   %esi
    12ac:	57                   	push   %edi
    12ad:	e8 0e 02 00 00       	call   14c0 <stat>
    12b2:	83 c4 10             	add    $0x10,%esp
    12b5:	85 c0                	test   %eax,%eax
    12b7:	78 5f                	js     1318 <ls+0x218>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    12b9:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
    12c0:	83 ec 0c             	sub    $0xc,%esp
    12c3:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
    12c9:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
    12cf:	57                   	push   %edi
    12d0:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
    12d6:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
    12dc:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    12e2:	e8 79 fd ff ff       	call   1060 <fmtname>
    12e7:	5a                   	pop    %edx
    12e8:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
    12ee:	59                   	pop    %ecx
    12ef:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
    12f5:	51                   	push   %ecx
    12f6:	52                   	push   %edx
    12f7:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
    12fd:	50                   	push   %eax
    12fe:	68 70 1a 00 00       	push   $0x1a70
    1303:	6a 01                	push   $0x1
    1305:	e8 e6 03 00 00       	call   16f0 <printf>
    130a:	83 c4 20             	add    $0x20,%esp
    130d:	e9 4e ff ff ff       	jmp    1260 <ls+0x160>
    1312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "ls: cannot stat %s\n", buf);
    1318:	83 ec 04             	sub    $0x4,%esp
    131b:	57                   	push   %edi
    131c:	68 5c 1a 00 00       	push   $0x1a5c
    1321:	6a 01                	push   $0x1
    1323:	e8 c8 03 00 00       	call   16f0 <printf>
        continue;
    1328:	83 c4 10             	add    $0x10,%esp
    132b:	e9 30 ff ff ff       	jmp    1260 <ls+0x160>

00001330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1330:	55                   	push   %ebp
    1331:	89 e5                	mov    %esp,%ebp
    1333:	53                   	push   %ebx
    1334:	8b 45 08             	mov    0x8(%ebp),%eax
    1337:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    133a:	89 c2                	mov    %eax,%edx
    133c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1340:	83 c1 01             	add    $0x1,%ecx
    1343:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1347:	83 c2 01             	add    $0x1,%edx
    134a:	84 db                	test   %bl,%bl
    134c:	88 5a ff             	mov    %bl,-0x1(%edx)
    134f:	75 ef                	jne    1340 <strcpy+0x10>
    ;
  return os;
}
    1351:	5b                   	pop    %ebx
    1352:	5d                   	pop    %ebp
    1353:	c3                   	ret    
    1354:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    135a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	53                   	push   %ebx
    1364:	8b 55 08             	mov    0x8(%ebp),%edx
    1367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    136a:	0f b6 02             	movzbl (%edx),%eax
    136d:	0f b6 19             	movzbl (%ecx),%ebx
    1370:	84 c0                	test   %al,%al
    1372:	75 1c                	jne    1390 <strcmp+0x30>
    1374:	eb 2a                	jmp    13a0 <strcmp+0x40>
    1376:	8d 76 00             	lea    0x0(%esi),%esi
    1379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1380:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1383:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1386:	83 c1 01             	add    $0x1,%ecx
    1389:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    138c:	84 c0                	test   %al,%al
    138e:	74 10                	je     13a0 <strcmp+0x40>
    1390:	38 d8                	cmp    %bl,%al
    1392:	74 ec                	je     1380 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1394:	29 d8                	sub    %ebx,%eax
}
    1396:	5b                   	pop    %ebx
    1397:	5d                   	pop    %ebp
    1398:	c3                   	ret    
    1399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    13a2:	29 d8                	sub    %ebx,%eax
}
    13a4:	5b                   	pop    %ebx
    13a5:	5d                   	pop    %ebp
    13a6:	c3                   	ret    
    13a7:	89 f6                	mov    %esi,%esi
    13a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013b0 <strlen>:

uint
strlen(const char *s)
{
    13b0:	55                   	push   %ebp
    13b1:	89 e5                	mov    %esp,%ebp
    13b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    13b6:	80 39 00             	cmpb   $0x0,(%ecx)
    13b9:	74 15                	je     13d0 <strlen+0x20>
    13bb:	31 d2                	xor    %edx,%edx
    13bd:	8d 76 00             	lea    0x0(%esi),%esi
    13c0:	83 c2 01             	add    $0x1,%edx
    13c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    13c7:	89 d0                	mov    %edx,%eax
    13c9:	75 f5                	jne    13c0 <strlen+0x10>
    ;
  return n;
}
    13cb:	5d                   	pop    %ebp
    13cc:	c3                   	ret    
    13cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    13d0:	31 c0                	xor    %eax,%eax
}
    13d2:	5d                   	pop    %ebp
    13d3:	c3                   	ret    
    13d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000013e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    13e0:	55                   	push   %ebp
    13e1:	89 e5                	mov    %esp,%ebp
    13e3:	57                   	push   %edi
    13e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    13e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ed:	89 d7                	mov    %edx,%edi
    13ef:	fc                   	cld    
    13f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    13f2:	89 d0                	mov    %edx,%eax
    13f4:	5f                   	pop    %edi
    13f5:	5d                   	pop    %ebp
    13f6:	c3                   	ret    
    13f7:	89 f6                	mov    %esi,%esi
    13f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001400 <strchr>:

char*
strchr(const char *s, char c)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	53                   	push   %ebx
    1404:	8b 45 08             	mov    0x8(%ebp),%eax
    1407:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    140a:	0f b6 10             	movzbl (%eax),%edx
    140d:	84 d2                	test   %dl,%dl
    140f:	74 1d                	je     142e <strchr+0x2e>
    if(*s == c)
    1411:	38 d3                	cmp    %dl,%bl
    1413:	89 d9                	mov    %ebx,%ecx
    1415:	75 0d                	jne    1424 <strchr+0x24>
    1417:	eb 17                	jmp    1430 <strchr+0x30>
    1419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1420:	38 ca                	cmp    %cl,%dl
    1422:	74 0c                	je     1430 <strchr+0x30>
  for(; *s; s++)
    1424:	83 c0 01             	add    $0x1,%eax
    1427:	0f b6 10             	movzbl (%eax),%edx
    142a:	84 d2                	test   %dl,%dl
    142c:	75 f2                	jne    1420 <strchr+0x20>
      return (char*)s;
  return 0;
    142e:	31 c0                	xor    %eax,%eax
}
    1430:	5b                   	pop    %ebx
    1431:	5d                   	pop    %ebp
    1432:	c3                   	ret    
    1433:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001440 <gets>:

char*
gets(char *buf, int max)
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	57                   	push   %edi
    1444:	56                   	push   %esi
    1445:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1446:	31 f6                	xor    %esi,%esi
    1448:	89 f3                	mov    %esi,%ebx
{
    144a:	83 ec 1c             	sub    $0x1c,%esp
    144d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1450:	eb 2f                	jmp    1481 <gets+0x41>
    1452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1458:	8d 45 e7             	lea    -0x19(%ebp),%eax
    145b:	83 ec 04             	sub    $0x4,%esp
    145e:	6a 01                	push   $0x1
    1460:	50                   	push   %eax
    1461:	6a 00                	push   $0x0
    1463:	e8 32 01 00 00       	call   159a <read>
    if(cc < 1)
    1468:	83 c4 10             	add    $0x10,%esp
    146b:	85 c0                	test   %eax,%eax
    146d:	7e 1c                	jle    148b <gets+0x4b>
      break;
    buf[i++] = c;
    146f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1473:	83 c7 01             	add    $0x1,%edi
    1476:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1479:	3c 0a                	cmp    $0xa,%al
    147b:	74 23                	je     14a0 <gets+0x60>
    147d:	3c 0d                	cmp    $0xd,%al
    147f:	74 1f                	je     14a0 <gets+0x60>
  for(i=0; i+1 < max; ){
    1481:	83 c3 01             	add    $0x1,%ebx
    1484:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1487:	89 fe                	mov    %edi,%esi
    1489:	7c cd                	jl     1458 <gets+0x18>
    148b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    148d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1490:	c6 03 00             	movb   $0x0,(%ebx)
}
    1493:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1496:	5b                   	pop    %ebx
    1497:	5e                   	pop    %esi
    1498:	5f                   	pop    %edi
    1499:	5d                   	pop    %ebp
    149a:	c3                   	ret    
    149b:	90                   	nop
    149c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    14a0:	8b 75 08             	mov    0x8(%ebp),%esi
    14a3:	8b 45 08             	mov    0x8(%ebp),%eax
    14a6:	01 de                	add    %ebx,%esi
    14a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    14aa:	c6 03 00             	movb   $0x0,(%ebx)
}
    14ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14b0:	5b                   	pop    %ebx
    14b1:	5e                   	pop    %esi
    14b2:	5f                   	pop    %edi
    14b3:	5d                   	pop    %ebp
    14b4:	c3                   	ret    
    14b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    14b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000014c0 <stat>:

int
stat(const char *n, struct stat *st)
{
    14c0:	55                   	push   %ebp
    14c1:	89 e5                	mov    %esp,%ebp
    14c3:	56                   	push   %esi
    14c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14c5:	83 ec 08             	sub    $0x8,%esp
    14c8:	6a 00                	push   $0x0
    14ca:	ff 75 08             	pushl  0x8(%ebp)
    14cd:	e8 f0 00 00 00       	call   15c2 <open>
  if(fd < 0)
    14d2:	83 c4 10             	add    $0x10,%esp
    14d5:	85 c0                	test   %eax,%eax
    14d7:	78 27                	js     1500 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    14d9:	83 ec 08             	sub    $0x8,%esp
    14dc:	ff 75 0c             	pushl  0xc(%ebp)
    14df:	89 c3                	mov    %eax,%ebx
    14e1:	50                   	push   %eax
    14e2:	e8 f3 00 00 00       	call   15da <fstat>
  close(fd);
    14e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    14ea:	89 c6                	mov    %eax,%esi
  close(fd);
    14ec:	e8 b9 00 00 00       	call   15aa <close>
  return r;
    14f1:	83 c4 10             	add    $0x10,%esp
}
    14f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    14f7:	89 f0                	mov    %esi,%eax
    14f9:	5b                   	pop    %ebx
    14fa:	5e                   	pop    %esi
    14fb:	5d                   	pop    %ebp
    14fc:	c3                   	ret    
    14fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1500:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1505:	eb ed                	jmp    14f4 <stat+0x34>
    1507:	89 f6                	mov    %esi,%esi
    1509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001510 <atoi>:

int
atoi(const char *s)
{
    1510:	55                   	push   %ebp
    1511:	89 e5                	mov    %esp,%ebp
    1513:	53                   	push   %ebx
    1514:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1517:	0f be 11             	movsbl (%ecx),%edx
    151a:	8d 42 d0             	lea    -0x30(%edx),%eax
    151d:	3c 09                	cmp    $0x9,%al
  n = 0;
    151f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1524:	77 1f                	ja     1545 <atoi+0x35>
    1526:	8d 76 00             	lea    0x0(%esi),%esi
    1529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1530:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1533:	83 c1 01             	add    $0x1,%ecx
    1536:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    153a:	0f be 11             	movsbl (%ecx),%edx
    153d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1540:	80 fb 09             	cmp    $0x9,%bl
    1543:	76 eb                	jbe    1530 <atoi+0x20>
  return n;
}
    1545:	5b                   	pop    %ebx
    1546:	5d                   	pop    %ebp
    1547:	c3                   	ret    
    1548:	90                   	nop
    1549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001550 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
    1553:	56                   	push   %esi
    1554:	53                   	push   %ebx
    1555:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1558:	8b 45 08             	mov    0x8(%ebp),%eax
    155b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    155e:	85 db                	test   %ebx,%ebx
    1560:	7e 14                	jle    1576 <memmove+0x26>
    1562:	31 d2                	xor    %edx,%edx
    1564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1568:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    156c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    156f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    1572:	39 d3                	cmp    %edx,%ebx
    1574:	75 f2                	jne    1568 <memmove+0x18>
  return vdst;
}
    1576:	5b                   	pop    %ebx
    1577:	5e                   	pop    %esi
    1578:	5d                   	pop    %ebp
    1579:	c3                   	ret    

0000157a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    157a:	b8 01 00 00 00       	mov    $0x1,%eax
    157f:	cd 40                	int    $0x40
    1581:	c3                   	ret    

00001582 <exit>:
SYSCALL(exit)
    1582:	b8 02 00 00 00       	mov    $0x2,%eax
    1587:	cd 40                	int    $0x40
    1589:	c3                   	ret    

0000158a <wait>:
SYSCALL(wait)
    158a:	b8 03 00 00 00       	mov    $0x3,%eax
    158f:	cd 40                	int    $0x40
    1591:	c3                   	ret    

00001592 <pipe>:
SYSCALL(pipe)
    1592:	b8 04 00 00 00       	mov    $0x4,%eax
    1597:	cd 40                	int    $0x40
    1599:	c3                   	ret    

0000159a <read>:
SYSCALL(read)
    159a:	b8 05 00 00 00       	mov    $0x5,%eax
    159f:	cd 40                	int    $0x40
    15a1:	c3                   	ret    

000015a2 <write>:
SYSCALL(write)
    15a2:	b8 10 00 00 00       	mov    $0x10,%eax
    15a7:	cd 40                	int    $0x40
    15a9:	c3                   	ret    

000015aa <close>:
SYSCALL(close)
    15aa:	b8 15 00 00 00       	mov    $0x15,%eax
    15af:	cd 40                	int    $0x40
    15b1:	c3                   	ret    

000015b2 <kill>:
SYSCALL(kill)
    15b2:	b8 06 00 00 00       	mov    $0x6,%eax
    15b7:	cd 40                	int    $0x40
    15b9:	c3                   	ret    

000015ba <exec>:
SYSCALL(exec)
    15ba:	b8 07 00 00 00       	mov    $0x7,%eax
    15bf:	cd 40                	int    $0x40
    15c1:	c3                   	ret    

000015c2 <open>:
SYSCALL(open)
    15c2:	b8 0f 00 00 00       	mov    $0xf,%eax
    15c7:	cd 40                	int    $0x40
    15c9:	c3                   	ret    

000015ca <mknod>:
SYSCALL(mknod)
    15ca:	b8 11 00 00 00       	mov    $0x11,%eax
    15cf:	cd 40                	int    $0x40
    15d1:	c3                   	ret    

000015d2 <unlink>:
SYSCALL(unlink)
    15d2:	b8 12 00 00 00       	mov    $0x12,%eax
    15d7:	cd 40                	int    $0x40
    15d9:	c3                   	ret    

000015da <fstat>:
SYSCALL(fstat)
    15da:	b8 08 00 00 00       	mov    $0x8,%eax
    15df:	cd 40                	int    $0x40
    15e1:	c3                   	ret    

000015e2 <link>:
SYSCALL(link)
    15e2:	b8 13 00 00 00       	mov    $0x13,%eax
    15e7:	cd 40                	int    $0x40
    15e9:	c3                   	ret    

000015ea <mkdir>:
SYSCALL(mkdir)
    15ea:	b8 14 00 00 00       	mov    $0x14,%eax
    15ef:	cd 40                	int    $0x40
    15f1:	c3                   	ret    

000015f2 <chdir>:
SYSCALL(chdir)
    15f2:	b8 09 00 00 00       	mov    $0x9,%eax
    15f7:	cd 40                	int    $0x40
    15f9:	c3                   	ret    

000015fa <dup>:
SYSCALL(dup)
    15fa:	b8 0a 00 00 00       	mov    $0xa,%eax
    15ff:	cd 40                	int    $0x40
    1601:	c3                   	ret    

00001602 <getpid>:
SYSCALL(getpid)
    1602:	b8 0b 00 00 00       	mov    $0xb,%eax
    1607:	cd 40                	int    $0x40
    1609:	c3                   	ret    

0000160a <sbrk>:
SYSCALL(sbrk)
    160a:	b8 0c 00 00 00       	mov    $0xc,%eax
    160f:	cd 40                	int    $0x40
    1611:	c3                   	ret    

00001612 <sleep>:
SYSCALL(sleep)
    1612:	b8 0d 00 00 00       	mov    $0xd,%eax
    1617:	cd 40                	int    $0x40
    1619:	c3                   	ret    

0000161a <uptime>:
SYSCALL(uptime)
    161a:	b8 0e 00 00 00       	mov    $0xe,%eax
    161f:	cd 40                	int    $0x40
    1621:	c3                   	ret    

00001622 <getyear>:
SYSCALL(getyear)
    1622:	b8 16 00 00 00       	mov    $0x16,%eax
    1627:	cd 40                	int    $0x40
    1629:	c3                   	ret    

0000162a <runtime>:
SYSCALL(runtime)
    162a:	b8 17 00 00 00       	mov    $0x17,%eax
    162f:	cd 40                	int    $0x40
    1631:	c3                   	ret    

00001632 <waittime>:
SYSCALL(waittime)
    1632:	b8 18 00 00 00       	mov    $0x18,%eax
    1637:	cd 40                	int    $0x40
    1639:	c3                   	ret    

0000163a <turntime>:
SYSCALL(turntime)
    163a:	b8 19 00 00 00       	mov    $0x19,%eax
    163f:	cd 40                	int    $0x40
    1641:	c3                   	ret    
    1642:	66 90                	xchg   %ax,%ax
    1644:	66 90                	xchg   %ax,%ax
    1646:	66 90                	xchg   %ax,%ax
    1648:	66 90                	xchg   %ax,%ax
    164a:	66 90                	xchg   %ax,%ax
    164c:	66 90                	xchg   %ax,%ax
    164e:	66 90                	xchg   %ax,%ax

00001650 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1650:	55                   	push   %ebp
    1651:	89 e5                	mov    %esp,%ebp
    1653:	57                   	push   %edi
    1654:	56                   	push   %esi
    1655:	53                   	push   %ebx
    1656:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1659:	85 d2                	test   %edx,%edx
{
    165b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    165e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1660:	79 76                	jns    16d8 <printint+0x88>
    1662:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    1666:	74 70                	je     16d8 <printint+0x88>
    x = -xx;
    1668:	f7 d8                	neg    %eax
    neg = 1;
    166a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1671:	31 f6                	xor    %esi,%esi
    1673:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1676:	eb 0a                	jmp    1682 <printint+0x32>
    1678:	90                   	nop
    1679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    1680:	89 fe                	mov    %edi,%esi
    1682:	31 d2                	xor    %edx,%edx
    1684:	8d 7e 01             	lea    0x1(%esi),%edi
    1687:	f7 f1                	div    %ecx
    1689:	0f b6 92 9c 1a 00 00 	movzbl 0x1a9c(%edx),%edx
  }while((x /= base) != 0);
    1690:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1692:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1695:	75 e9                	jne    1680 <printint+0x30>
  if(neg)
    1697:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    169a:	85 c0                	test   %eax,%eax
    169c:	74 08                	je     16a6 <printint+0x56>
    buf[i++] = '-';
    169e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    16a3:	8d 7e 02             	lea    0x2(%esi),%edi
    16a6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    16aa:	8b 7d c0             	mov    -0x40(%ebp),%edi
    16ad:	8d 76 00             	lea    0x0(%esi),%esi
    16b0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    16b3:	83 ec 04             	sub    $0x4,%esp
    16b6:	83 ee 01             	sub    $0x1,%esi
    16b9:	6a 01                	push   $0x1
    16bb:	53                   	push   %ebx
    16bc:	57                   	push   %edi
    16bd:	88 45 d7             	mov    %al,-0x29(%ebp)
    16c0:	e8 dd fe ff ff       	call   15a2 <write>

  while(--i >= 0)
    16c5:	83 c4 10             	add    $0x10,%esp
    16c8:	39 de                	cmp    %ebx,%esi
    16ca:	75 e4                	jne    16b0 <printint+0x60>
    putc(fd, buf[i]);
}
    16cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16cf:	5b                   	pop    %ebx
    16d0:	5e                   	pop    %esi
    16d1:	5f                   	pop    %edi
    16d2:	5d                   	pop    %ebp
    16d3:	c3                   	ret    
    16d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    16d8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    16df:	eb 90                	jmp    1671 <printint+0x21>
    16e1:	eb 0d                	jmp    16f0 <printf>
    16e3:	90                   	nop
    16e4:	90                   	nop
    16e5:	90                   	nop
    16e6:	90                   	nop
    16e7:	90                   	nop
    16e8:	90                   	nop
    16e9:	90                   	nop
    16ea:	90                   	nop
    16eb:	90                   	nop
    16ec:	90                   	nop
    16ed:	90                   	nop
    16ee:	90                   	nop
    16ef:	90                   	nop

000016f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    16f0:	55                   	push   %ebp
    16f1:	89 e5                	mov    %esp,%ebp
    16f3:	57                   	push   %edi
    16f4:	56                   	push   %esi
    16f5:	53                   	push   %ebx
    16f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16f9:	8b 75 0c             	mov    0xc(%ebp),%esi
    16fc:	0f b6 1e             	movzbl (%esi),%ebx
    16ff:	84 db                	test   %bl,%bl
    1701:	0f 84 b3 00 00 00    	je     17ba <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    1707:	8d 45 10             	lea    0x10(%ebp),%eax
    170a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    170d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    170f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1712:	eb 2f                	jmp    1743 <printf+0x53>
    1714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1718:	83 f8 25             	cmp    $0x25,%eax
    171b:	0f 84 a7 00 00 00    	je     17c8 <printf+0xd8>
  write(fd, &c, 1);
    1721:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1724:	83 ec 04             	sub    $0x4,%esp
    1727:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    172a:	6a 01                	push   $0x1
    172c:	50                   	push   %eax
    172d:	ff 75 08             	pushl  0x8(%ebp)
    1730:	e8 6d fe ff ff       	call   15a2 <write>
    1735:	83 c4 10             	add    $0x10,%esp
    1738:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    173b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    173f:	84 db                	test   %bl,%bl
    1741:	74 77                	je     17ba <printf+0xca>
    if(state == 0){
    1743:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1745:	0f be cb             	movsbl %bl,%ecx
    1748:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    174b:	74 cb                	je     1718 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    174d:	83 ff 25             	cmp    $0x25,%edi
    1750:	75 e6                	jne    1738 <printf+0x48>
      if(c == 'd'){
    1752:	83 f8 64             	cmp    $0x64,%eax
    1755:	0f 84 05 01 00 00    	je     1860 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    175b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1761:	83 f9 70             	cmp    $0x70,%ecx
    1764:	74 72                	je     17d8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1766:	83 f8 73             	cmp    $0x73,%eax
    1769:	0f 84 99 00 00 00    	je     1808 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    176f:	83 f8 63             	cmp    $0x63,%eax
    1772:	0f 84 08 01 00 00    	je     1880 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1778:	83 f8 25             	cmp    $0x25,%eax
    177b:	0f 84 ef 00 00 00    	je     1870 <printf+0x180>
  write(fd, &c, 1);
    1781:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1784:	83 ec 04             	sub    $0x4,%esp
    1787:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    178b:	6a 01                	push   $0x1
    178d:	50                   	push   %eax
    178e:	ff 75 08             	pushl  0x8(%ebp)
    1791:	e8 0c fe ff ff       	call   15a2 <write>
    1796:	83 c4 0c             	add    $0xc,%esp
    1799:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    179c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    179f:	6a 01                	push   $0x1
    17a1:	50                   	push   %eax
    17a2:	ff 75 08             	pushl  0x8(%ebp)
    17a5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    17a8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    17aa:	e8 f3 fd ff ff       	call   15a2 <write>
  for(i = 0; fmt[i]; i++){
    17af:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    17b3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    17b6:	84 db                	test   %bl,%bl
    17b8:	75 89                	jne    1743 <printf+0x53>
    }
  }
}
    17ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
    17bd:	5b                   	pop    %ebx
    17be:	5e                   	pop    %esi
    17bf:	5f                   	pop    %edi
    17c0:	5d                   	pop    %ebp
    17c1:	c3                   	ret    
    17c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    17c8:	bf 25 00 00 00       	mov    $0x25,%edi
    17cd:	e9 66 ff ff ff       	jmp    1738 <printf+0x48>
    17d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    17d8:	83 ec 0c             	sub    $0xc,%esp
    17db:	b9 10 00 00 00       	mov    $0x10,%ecx
    17e0:	6a 00                	push   $0x0
    17e2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    17e5:	8b 45 08             	mov    0x8(%ebp),%eax
    17e8:	8b 17                	mov    (%edi),%edx
    17ea:	e8 61 fe ff ff       	call   1650 <printint>
        ap++;
    17ef:	89 f8                	mov    %edi,%eax
    17f1:	83 c4 10             	add    $0x10,%esp
      state = 0;
    17f4:	31 ff                	xor    %edi,%edi
        ap++;
    17f6:	83 c0 04             	add    $0x4,%eax
    17f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    17fc:	e9 37 ff ff ff       	jmp    1738 <printf+0x48>
    1801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1808:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    180b:	8b 08                	mov    (%eax),%ecx
        ap++;
    180d:	83 c0 04             	add    $0x4,%eax
    1810:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1813:	85 c9                	test   %ecx,%ecx
    1815:	0f 84 8e 00 00 00    	je     18a9 <printf+0x1b9>
        while(*s != 0){
    181b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    181e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1820:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1822:	84 c0                	test   %al,%al
    1824:	0f 84 0e ff ff ff    	je     1738 <printf+0x48>
    182a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    182d:	89 de                	mov    %ebx,%esi
    182f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1832:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    1835:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1838:	83 ec 04             	sub    $0x4,%esp
          s++;
    183b:	83 c6 01             	add    $0x1,%esi
    183e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1841:	6a 01                	push   $0x1
    1843:	57                   	push   %edi
    1844:	53                   	push   %ebx
    1845:	e8 58 fd ff ff       	call   15a2 <write>
        while(*s != 0){
    184a:	0f b6 06             	movzbl (%esi),%eax
    184d:	83 c4 10             	add    $0x10,%esp
    1850:	84 c0                	test   %al,%al
    1852:	75 e4                	jne    1838 <printf+0x148>
    1854:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1857:	31 ff                	xor    %edi,%edi
    1859:	e9 da fe ff ff       	jmp    1738 <printf+0x48>
    185e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1860:	83 ec 0c             	sub    $0xc,%esp
    1863:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1868:	6a 01                	push   $0x1
    186a:	e9 73 ff ff ff       	jmp    17e2 <printf+0xf2>
    186f:	90                   	nop
  write(fd, &c, 1);
    1870:	83 ec 04             	sub    $0x4,%esp
    1873:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1876:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1879:	6a 01                	push   $0x1
    187b:	e9 21 ff ff ff       	jmp    17a1 <printf+0xb1>
        putc(fd, *ap);
    1880:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1883:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1886:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1888:	6a 01                	push   $0x1
        ap++;
    188a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    188d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1890:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1893:	50                   	push   %eax
    1894:	ff 75 08             	pushl  0x8(%ebp)
    1897:	e8 06 fd ff ff       	call   15a2 <write>
        ap++;
    189c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    189f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    18a2:	31 ff                	xor    %edi,%edi
    18a4:	e9 8f fe ff ff       	jmp    1738 <printf+0x48>
          s = "(null)";
    18a9:	bb 92 1a 00 00       	mov    $0x1a92,%ebx
        while(*s != 0){
    18ae:	b8 28 00 00 00       	mov    $0x28,%eax
    18b3:	e9 72 ff ff ff       	jmp    182a <printf+0x13a>
    18b8:	66 90                	xchg   %ax,%ax
    18ba:	66 90                	xchg   %ax,%ax
    18bc:	66 90                	xchg   %ax,%ax
    18be:	66 90                	xchg   %ax,%ax

000018c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18c1:	a1 cc 1d 00 00       	mov    0x1dcc,%eax
{
    18c6:	89 e5                	mov    %esp,%ebp
    18c8:	57                   	push   %edi
    18c9:	56                   	push   %esi
    18ca:	53                   	push   %ebx
    18cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    18ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    18d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18d8:	39 c8                	cmp    %ecx,%eax
    18da:	8b 10                	mov    (%eax),%edx
    18dc:	73 32                	jae    1910 <free+0x50>
    18de:	39 d1                	cmp    %edx,%ecx
    18e0:	72 04                	jb     18e6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18e2:	39 d0                	cmp    %edx,%eax
    18e4:	72 32                	jb     1918 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    18e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    18e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    18ec:	39 fa                	cmp    %edi,%edx
    18ee:	74 30                	je     1920 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    18f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    18f3:	8b 50 04             	mov    0x4(%eax),%edx
    18f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    18f9:	39 f1                	cmp    %esi,%ecx
    18fb:	74 3a                	je     1937 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    18fd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    18ff:	a3 cc 1d 00 00       	mov    %eax,0x1dcc
}
    1904:	5b                   	pop    %ebx
    1905:	5e                   	pop    %esi
    1906:	5f                   	pop    %edi
    1907:	5d                   	pop    %ebp
    1908:	c3                   	ret    
    1909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1910:	39 d0                	cmp    %edx,%eax
    1912:	72 04                	jb     1918 <free+0x58>
    1914:	39 d1                	cmp    %edx,%ecx
    1916:	72 ce                	jb     18e6 <free+0x26>
{
    1918:	89 d0                	mov    %edx,%eax
    191a:	eb bc                	jmp    18d8 <free+0x18>
    191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1920:	03 72 04             	add    0x4(%edx),%esi
    1923:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1926:	8b 10                	mov    (%eax),%edx
    1928:	8b 12                	mov    (%edx),%edx
    192a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    192d:	8b 50 04             	mov    0x4(%eax),%edx
    1930:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1933:	39 f1                	cmp    %esi,%ecx
    1935:	75 c6                	jne    18fd <free+0x3d>
    p->s.size += bp->s.size;
    1937:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    193a:	a3 cc 1d 00 00       	mov    %eax,0x1dcc
    p->s.size += bp->s.size;
    193f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1942:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1945:	89 10                	mov    %edx,(%eax)
}
    1947:	5b                   	pop    %ebx
    1948:	5e                   	pop    %esi
    1949:	5f                   	pop    %edi
    194a:	5d                   	pop    %ebp
    194b:	c3                   	ret    
    194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001950 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1950:	55                   	push   %ebp
    1951:	89 e5                	mov    %esp,%ebp
    1953:	57                   	push   %edi
    1954:	56                   	push   %esi
    1955:	53                   	push   %ebx
    1956:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1959:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    195c:	8b 15 cc 1d 00 00    	mov    0x1dcc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1962:	8d 78 07             	lea    0x7(%eax),%edi
    1965:	c1 ef 03             	shr    $0x3,%edi
    1968:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    196b:	85 d2                	test   %edx,%edx
    196d:	0f 84 9d 00 00 00    	je     1a10 <malloc+0xc0>
    1973:	8b 02                	mov    (%edx),%eax
    1975:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1978:	39 cf                	cmp    %ecx,%edi
    197a:	76 6c                	jbe    19e8 <malloc+0x98>
    197c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1982:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1987:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    198a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1991:	eb 0e                	jmp    19a1 <malloc+0x51>
    1993:	90                   	nop
    1994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1998:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    199a:	8b 48 04             	mov    0x4(%eax),%ecx
    199d:	39 f9                	cmp    %edi,%ecx
    199f:	73 47                	jae    19e8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    19a1:	39 05 cc 1d 00 00    	cmp    %eax,0x1dcc
    19a7:	89 c2                	mov    %eax,%edx
    19a9:	75 ed                	jne    1998 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    19ab:	83 ec 0c             	sub    $0xc,%esp
    19ae:	56                   	push   %esi
    19af:	e8 56 fc ff ff       	call   160a <sbrk>
  if(p == (char*)-1)
    19b4:	83 c4 10             	add    $0x10,%esp
    19b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    19ba:	74 1c                	je     19d8 <malloc+0x88>
  hp->s.size = nu;
    19bc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    19bf:	83 ec 0c             	sub    $0xc,%esp
    19c2:	83 c0 08             	add    $0x8,%eax
    19c5:	50                   	push   %eax
    19c6:	e8 f5 fe ff ff       	call   18c0 <free>
  return freep;
    19cb:	8b 15 cc 1d 00 00    	mov    0x1dcc,%edx
      if((p = morecore(nunits)) == 0)
    19d1:	83 c4 10             	add    $0x10,%esp
    19d4:	85 d2                	test   %edx,%edx
    19d6:	75 c0                	jne    1998 <malloc+0x48>
        return 0;
  }
}
    19d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    19db:	31 c0                	xor    %eax,%eax
}
    19dd:	5b                   	pop    %ebx
    19de:	5e                   	pop    %esi
    19df:	5f                   	pop    %edi
    19e0:	5d                   	pop    %ebp
    19e1:	c3                   	ret    
    19e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    19e8:	39 cf                	cmp    %ecx,%edi
    19ea:	74 54                	je     1a40 <malloc+0xf0>
        p->s.size -= nunits;
    19ec:	29 f9                	sub    %edi,%ecx
    19ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    19f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    19f4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    19f7:	89 15 cc 1d 00 00    	mov    %edx,0x1dcc
}
    19fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1a00:	83 c0 08             	add    $0x8,%eax
}
    1a03:	5b                   	pop    %ebx
    1a04:	5e                   	pop    %esi
    1a05:	5f                   	pop    %edi
    1a06:	5d                   	pop    %ebp
    1a07:	c3                   	ret    
    1a08:	90                   	nop
    1a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1a10:	c7 05 cc 1d 00 00 d0 	movl   $0x1dd0,0x1dcc
    1a17:	1d 00 00 
    1a1a:	c7 05 d0 1d 00 00 d0 	movl   $0x1dd0,0x1dd0
    1a21:	1d 00 00 
    base.s.size = 0;
    1a24:	b8 d0 1d 00 00       	mov    $0x1dd0,%eax
    1a29:	c7 05 d4 1d 00 00 00 	movl   $0x0,0x1dd4
    1a30:	00 00 00 
    1a33:	e9 44 ff ff ff       	jmp    197c <malloc+0x2c>
    1a38:	90                   	nop
    1a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1a40:	8b 08                	mov    (%eax),%ecx
    1a42:	89 0a                	mov    %ecx,(%edx)
    1a44:	eb b1                	jmp    19f7 <malloc+0xa7>
