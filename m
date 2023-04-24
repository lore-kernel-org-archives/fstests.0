Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B36CC77B7F
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Apr 2023 10:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjDXKSC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 06:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjDXKSB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 06:18:01 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90B6D8
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 03:17:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VgswNQs_1682331476;
Received: from 30.97.56.227(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VgswNQs_1682331476)
          by smtp.aliyun-inc.com;
          Mon, 24 Apr 2023 18:17:57 +0800
Message-ID: <7243f364-e822-ce43-7e46-783c317d0a67@linux.alibaba.com>
Date:   Mon, 24 Apr 2023 18:17:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2] src: fix detached_mounts_propagation compile errors
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
References: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
 <20230420021106.41970-1-hsiangkao@linux.alibaba.com>
 <20230422135427.vbrnj6vh46omo34e@zlang-mailbox>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230422135427.vbrnj6vh46omo34e@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023/4/22 21:54, Zorro Lang wrote:
> On Thu, Apr 20, 2023 at 10:11:06AM +0800, Gao Xiang wrote:
>> Newer glibc such as glibc 2.36 also defines 'struct mount_attr'
>> in addition to <linux/mount.h>.  It will report as below when
>> compiling with old linux kernel headers (without idmapped mounts,
>> such as kernel-headers 5.10.134) but with newer glibc (here checked
>> with glibc 2.36.6):
>>
>>     [CC]    detached_mounts_propagation
>> In file included from detached_mounts_propagation.c:29:
>> vfs/missing.h:115:8: error: redefinition of 'struct mount_attr'
>>   115 | struct mount_attr {
>>       |        ^~~~~~~~~~
>> In file included from detached_mounts_propagation.c:23:
>> /usr/include/sys/mount.h:210:8: note: originally defined here
>>   210 | struct mount_attr
>>       |        ^~~~~~~~~~
>> gmake[3]: *** [Makefile:102: detached_mounts_propagation] Error 1
>> gmake[2]: *** [include/buildrules:31: src] Error 2
>> make[1]: *** [Makefile:51: default] Error 2
>> make: *** [Makefile:49: default] Error 2
>>
>> Let's get rid of <linux/mount.h> as Christian suggested to avoid
>> potential incompatibility between these two headers.
>>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
> 
> This patch works on latest fedora, but it cause fstests can't be built on
> RHEL-8 [1] and RHEL-9 [2], please check this incompatible problem.
> 
> Thanks,
> Zorro
> 
> [1]
> ...
> Building include
> Building lib
> Building ltp
> Building src
>     [CC]    feature
> In file included from /usr/include/linux/fs.h:18,
>                  from /usr/include/xfs/linux.h:30,
>                  from /usr/include/xfs/xfs.h:9,
>                  from global.h:13,
>                  from feature.c:29:
> /usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
>    MS_RDONLY = 1,  /* Mount read-only.  */
>    ^~~~~~~~~
> gmake[2]: *** [Makefile:112: feature] Error 1
> gmake[1]: *** [include/buildrules:31: src] Error 2
> make: *** [Makefile:51: default] Error 2
> 
> [2]
> ...
> Building include
> Building lib
> Building ltp
> Building src
>     [CC]    feature
> In file included from /usr/include/linux/fs.h:19,
>                  from /usr/include/xfs/linux.h:36,
>                  from /usr/include/xfs/xfs.h:9,
>                  from global.h:13,
>                  from feature.c:29:
> /usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
>    35 |   MS_RDONLY = 1,                /* Mount read-only.  */
>       |   ^~~~~~~~~
> In file included from feature.c:49:
> vfs/missing.h:116:8: error: redefinition of 'struct mount_attr'
>   116 | struct mount_attr {
>       |        ^~~~~~~~~~
> In file included from /usr/include/linux/fs.h:19,
>                  from /usr/include/xfs/linux.h:36,
>                  from /usr/include/xfs/xfs.h:9,
>                  from global.h:13,
>                  from feature.c:29:
> /usr/include/linux/mount.h:128:8: note: originally defined here
>   128 | struct mount_attr {
>       |        ^~~~~~~~~~
> gmake[2]: *** [Makefile:112: feature] Error 1
> gmake[1]: *** [include/buildrules:31: src] Error 2
> make: *** [Makefile:51: default] Error 2
> 
> 
>>  configure.ac                      | 2 +-
>>  src/detached_mounts_propagation.c | 1 -
>>  src/vfs/missing.h                 | 1 +
>>  3 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 4687d8a3..bb29f37e 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -74,7 +74,7 @@ AC_HAVE_FIEXCHANGE
>>  
>>  AC_CHECK_FUNCS([renameat2])
>>  AC_CHECK_FUNCS([reallocarray])
>> -AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
>> +AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <sys/mount.h>]])
>>  AC_CHECK_TYPES([struct btrfs_qgroup_limit], [], [], [[
>>  #include <stddef.h>
>>  #include <linux/btrfs.h>
>> diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
>> index 17db2c02..4041c75f 100644
>> --- a/src/detached_mounts_propagation.c
>> +++ b/src/detached_mounts_propagation.c
>> @@ -20,7 +20,6 @@
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <string.h>
>> -#include <sys/mount.h>
>>  #include <sys/stat.h>
>>  #include <sys/syscall.h>
>>  #include <sys/types.h>
>> diff --git a/src/vfs/missing.h b/src/vfs/missing.h
>> index 059e742d..04ab33d1 100644
>> --- a/src/vfs/missing.h
>> +++ b/src/vfs/missing.h
>> @@ -18,6 +18,7 @@
>>  #include <sys/types.h>
>>  #include <syscall.h>
>>  #include <unistd.h>
>> +#include <sys/mount.h>
>>  
>>  #ifndef __NR_mount_setattr
>>  	#if defined __alpha__
>> -- 
>> 2.24.4
>>

Hi Zorro,

Can you try this patch, which is inspired by Yang Xu[1].

[1]https://lore.kernel.org/fstests/ed0bb9f0-c255-10d7-d711-36a464cd6512@fujitsu.com/T/#me981ae064b3ecb151b3321a4ee77f5d916cb017c

Regards,
Zhang


Patch:

diff --git a/configure.ac b/configure.ac
index cbf83779..060c0a5d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -16,6 +16,7 @@ AC_CHECK_HEADERS([	assert.h		\
 			sys/uuid.h		\
 			sys/file.h		\
 			sys/fcntl.h		\
+			sys/mount.h		\
 			sys/syssgi.h		\
 			sys/param.h		\
 			sys/stat.h		\
@@ -27,6 +28,7 @@ AC_CHECK_HEADERS([	assert.h		\
 			strings.h		\
 			err.h			\
 			linux/falloc.h		\
+			linux/mount.h		\
 			sys/fs/xfs_fsops.h	\
 			sys/fs/xfs_itable.h	\
 			xfs/platform_defs.h	\
@@ -35,6 +37,10 @@ AC_CHECK_HEADERS([	assert.h		\
 			sys/mman.h		\
 ])
 
+AC_CHECK_FUNCS_ONCE([
+	mount_setattr	
+])
+
 AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
 #define _GNU_SOURCE
 #include <xfs/libxfs.h>])
@@ -68,7 +74,13 @@ AC_PACKAGE_WANT_LIBBTRFSUTIL
 AC_HAVE_COPY_FILE_RANGE
 AC_CHECK_FUNCS([renameat2])
 AC_CHECK_FUNCS([reallocarray])
-AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
+AC_CHECK_TYPES([struct mount_attr], [], [],[[
+#ifdef HAVE_MOUNT_SETATTR
+# include <sys/mount.h>
+#elif HAVE_LINUX_MOUNT_H
+# include <linux/mount.h>
+#endif
+]])
 AC_CHECK_TYPES([struct btrfs_qgroup_limit], [], [], [[
 #include <stddef.h>
 #include <linux/btrfs.h>
diff --git a/src/vfs/missing.h b/src/vfs/missing.h
index 059e742d..04ab33d1 100644
--- a/src/vfs/missing.h
+++ b/src/vfs/missing.h
@@ -18,6 +18,7 @@
 #include <sys/types.h>
 #include <syscall.h>
 #include <unistd.h>
+#include <sys/mount.h>
 
 #ifndef __NR_mount_setattr
 	#if defined __alpha__

