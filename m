Received: from mail-pg0-f46.google.com ([74.125.83.46]:43265 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeEKJ2D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 May 2018 05:28:03 -0400
Date: Fri, 11 May 2018 17:27:58 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: xfstests (git) results for sparc64
Message-ID: <20180511092758.GN8373@desktop>
References: <CADxRZqzKAHpGJGPZqh9uAfz7664y-aWhXOKsgnPCfetqSAZ4+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqzKAHpGJGPZqh9uAfz7664y-aWhXOKsgnPCfetqSAZ4+g@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Anatoly Pugachev <matorola@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Sparc kernel list <sparclinux@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, May 11, 2018 at 11:38:56AM +0300, Anatoly Pugachev wrote:
> Hello!
> 
> Run a testsuite for xfs filesystem on sparc64 hardware with
> xfsprogs-v4.16.0-rc1 (in PATH).
> 
> machine is linux sparc64 debian unstable/sid :
> 
> Linux ttip 4.17.0-rc4-00038-g008464a9360e #705 SMP Thu May 10 11:15:17
> MSK 2018 sparc64 GNU/Linux
> 
> root@ttip:/1/mator/xfstests-dev# git desc
> v1.1.0-2114-g00e3549c
> 
> results:
> 
> Not run: generic/009 generic/038 generic/260 generic/288 generic/362
> generic/363 generic/364 generic/365 generic/366 generic/367
> generic/368 generic/369 generic/370 generic/395 generic/396
> generic/397 generic/398 generic/399 generic/402 generic/413
> generic/419 generic/421 generic/429 generic/435 generic/440
> generic/455 generic/457 generic/462 generic/470 generic/471
> generic/482 shared/001 shared/003 shared/004 shared/272 shared/289
> xfs/016 xfs/035 xfs/040 xfs/044 xfs/090 xfs/094 xfs/096 xfs/114
> xfs/115 xfs/122 xfs/131 xfs/148 xfs/149 xfs/186 xfs/187 xfs/189
> xfs/197 xfs/233 xfs/234 xfs/236 xfs/244 xfs/260 xfs/271 xfs/272
> xfs/274 xfs/275 xfs/276 xfs/277 xfs/287 xfs/300 xfs/310 xfs/314
> xfs/317 xfs/322 xfs/329 xfs/331 xfs/332 xfs/333 xfs/334 xfs/335
> xfs/336 xfs/338 xfs/339 xfs/340 xfs/341 xfs/342 xfs/343 xfs/419
> xfs/434 xfs/435 xfs/436 xfs/437 xfs/439
> Failures: generic/068 generic/484 xfs/191-input-validation xfs/263 xfs/442
> Failed 5 of 683 tests
> 
> generic/068 and xfs/442 is a random failures, on the second run they passed ok.
> 
> generic/483 7s ... 11s
> generic/484      - output mismatch (see
> /1/mator/xfstests-dev/results//generic/484.out.bad)
>     --- tests/generic/484.out   2018-05-10 14:35:44.038023164 +0300
>     +++ /1/mator/xfstests-dev/results//generic/484.out.bad
> 2018-05-11 10:16:30.380662717 +0300
>     @@ -1,2 +1,3 @@
>      QA output created by 484
>     +record lock is not preserved across execve(2)
>      Silence is golden
>     ...
>     (Run 'diff -u tests/generic/484.out
> /1/mator/xfstests-dev/results//generic/484.out.bad'  to see the entire
> diff)

This is a known issue, the mentioned patch in tests/generic/484 is not
upstreamed yet.

> generic/485 1s ... 2s
> ...
> xfs/190 1s ... 1s
> xfs/191-input-validation 16s ... - output mismatch (see
> /1/mator/xfstests-dev/results//xfs/191-input-validation.out.bad)
>     --- tests/xfs/191-input-validation.out      2016-09-24
> 11:51:48.422898232 +0300
>     +++ /1/mator/xfstests-dev/results//xfs/191-input-validation.out.bad
> 2018-05-11 10:28:13.351578553 +0300
>     @@ -1,2 +1,12 @@
>      QA output created by 191-input-validation
>      silence is golden
>     +pass -n size=2b /dev/vdiske1
>     +pass -d agsize=8192b /dev/vdiske1
>     +pass -d agsize=65536s /dev/vdiske1
>     +pass -d sunit=0,swidth=64 /dev/vdiske1
>     +pass -d su=0,sw=64 /dev/vdiske1
>     ...
>     (Run 'diff -u tests/xfs/191-input-validation.out
> /1/mator/xfstests-dev/results//xfs/191-input-validation.out.bad'  to
> see the entire diff)

AFAIK, this test is broken, you could ignore it for now. We may want to
remove it from 'auto' group.

> xfs/192 4s ... 5s
> ...
> xfs/261 1s ... 1s
> xfs/263 7s ... - output mismatch (see
> /1/mator/xfstests-dev/results//xfs/263.out.bad)
>     --- tests/xfs/263.out       2017-02-23 13:00:44.458740721 +0300
>     +++ /1/mator/xfstests-dev/results//xfs/263.out.bad  2018-05-11
> 10:32:06.271819545 +0300
>     @@ -1,5 +1,7 @@
>      QA output created by 263
>      ==== NO CRC ====
>     +specified blocksize 4096 is less than device physical sector size 8192
>     +switching to logical sector size 512
>      == Options: rw ==
>      == Options: usrquota,rw ==
>      User quota state on SCRATCH_MNT (SCRATCH_DEV)
>     ...
>     (Run 'diff -u tests/xfs/263.out
> /1/mator/xfstests-dev/results//xfs/263.out.bad'  to see the entire
> diff)

This should not happen, we filter out such messages in
_scratch_mkfs_xfs(). Oh, I see it, xfs/263 just doesn't use the helper
function but call mkfs.xfs directly.. Seems like we could use the helper
safely here.

Thanks,
Eryu

> xfs/264 12s ... 11s
> 
> 
> 
> root@ttip:/1/mator/xfstests-dev# diff -u tests/generic/484.out
> /1/mator/xfstests-dev/results//generic/484.out.bad
> --- tests/generic/484.out       2018-05-10 14:35:44.038023164 +0300
> +++ /1/mator/xfstests-dev/results//generic/484.out.bad  2018-05-11
> 10:16:30.380662717 +0300
> @@ -1,2 +1,3 @@
>  QA output created by 484
> +record lock is not preserved across execve(2)
>  Silence is golden
> root@ttip:/1/mator/xfstests-dev#
> 
> 
> root@ttip:/1/mator/xfstests-dev# diff -u
> tests/xfs/191-input-validation.out
> /1/mator/xfstests-dev/results//xfs/191-input-validation.out.bad
> --- tests/xfs/191-input-validation.out  2016-09-24 11:51:48.422898232 +0300
> +++ /1/mator/xfstests-dev/results//xfs/191-input-validation.out.bad
>  2018-05-11 10:28:13.351578553 +0300
> @@ -1,2 +1,12 @@
>  QA output created by 191-input-validation
>  silence is golden
> +pass -n size=2b /dev/vdiske1
> +pass -d agsize=8192b /dev/vdiske1
> +pass -d agsize=65536s /dev/vdiske1
> +pass -d sunit=0,swidth=64 /dev/vdiske1
> +pass -d su=0,sw=64 /dev/vdiske1
> +pass -d su=4096s,sw=64 /dev/vdiske1
> +pass -d su=4096b,sw=64 /dev/vdiske1
> +pass -l su=10b /dev/vdiske1
> +fail -n log=15 /dev/vdiske1
> +fail -i log=10 /dev/vdiske1
> root@ttip:/1/mator/xfstests-dev#
> 
> 
> 
> root@ttip:/1/mator/xfstests-dev# diff -u tests/xfs/263.out
> /1/mator/xfstests-dev/results//xfs/263.out.bad
> --- tests/xfs/263.out   2017-02-23 13:00:44.458740721 +0300
> +++ /1/mator/xfstests-dev/results//xfs/263.out.bad      2018-05-11
> 10:32:06.271819545 +0300
> @@ -1,5 +1,7 @@
>  QA output created by 263
>  ==== NO CRC ====
> +specified blocksize 4096 is less than device physical sector size 8192
> +switching to logical sector size 512
>  == Options: rw ==
>  == Options: usrquota,rw ==
>  User quota state on SCRATCH_MNT (SCRATCH_DEV)
> @@ -84,6 +86,8 @@
>  == Options: grpquota,prjquota,rw ==
>  == Options: usrquota,grpquota,prjquota,rw ==
>  ==== CRC ====
> +specified blocksize 4096 is less than device physical sector size 8192
> +switching to logical sector size 512
>  == Options: rw ==
>  == Options: usrquota,rw ==
>  User quota state on SCRATCH_MNT (SCRATCH_DEV)
> root@ttip:/1/mator/xfstests-dev#
> 
> 
> config details for xfstests-dev below :
> 
> 
> root@ttip:/1/mator/xfstests-dev# cat local.config
> export TEST_DIR=/1/testvol
> export TEST_DEV=/dev/vdiskb1
> export SCRATCH_MNT=/1/scratch
> export SCRATCH_DEV="/dev/vdiske1"
> export SCRATCH_LOGDEV="/dev/loop0"
> export MKFS_OPTIONS="-m reflink=1"
> 
> /dev/loop0 is on ramdisk / tmpfs:
> 
> root@ttip:/1/mator/xfstests-dev# losetup
> NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE      DIO LOG-SEC
> /dev/loop0         0      0         0  0 /ramdisk/file0   0     512
> 
> root@ttip:/1/mator/xfstests-dev# findmnt /ramdisk/
> TARGET   SOURCE FSTYPE OPTIONS
> /ramdisk tmpfs  tmpfs  rw,relatime,size=32505856k
> 
> root@ttip:/1/mator/xfstests-dev# lsblk -si | egrep "NAME|loop0|vdisk(b|e)"
> NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
> loop0          7:0    0    20G  0 loop
> vdiskb1      254:9    0    30G  0 part
> `-vdiskb     254:8    0    30G  0 disk
> vdiske1      254:33   0    30G  0 part
> `-vdiske     254:32   0    30G  0 disk
> root@ttip:/1/mator/xfstests-dev#
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
