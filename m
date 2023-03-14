Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4A5C6FD1C
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Mar 2023 11:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCNLlV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCNLlU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2023 07:41:20 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3F99C0A
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 04:41:17 -0700 (PDT)
Received: from [IPV6:2a02:8109:aa40:4e0:fc60:ae3e:2f1d:8bfc]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 14 Mar 2023 11:41:13 +0000
Message-ID: <ec5a056d-d07c-2658-0695-2da1589f0666@sdfg.com.ar>
Date:   Tue, 14 Mar 2023 12:41:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 9/9] vfs: Add tmpfs tests for idmap mounts
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
 <20230313190330.94229-10-rodrigo@sdfg.com.ar>
 <20230314103905.iegn4sqhechxzqew@zlang-mailbox>
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20230314103905.iegn4sqhechxzqew@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/14/23 11:39, Zorro Lang wrote:
> On Mon, Mar 13, 2023 at 08:03:30PM +0100, Rodrigo Campos wrote:
>> This patch calls all tests in the suite s_idmapped_mounts, but with a
>> tmpfs directory mounted inside a userns. This directory is setup as the
>> mount point for the test that runs nested.
>>
>> This excercises that tmpfs mounted inside a userns works as expected
>> regarding idmap mounts.
>>
>> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
>> ---
>>   src/vfs/Makefile                |   4 +-
>>   src/vfs/tmpfs-idmapped-mounts.c | 305 ++++++++++++++++++++++++++++++++
>>   src/vfs/tmpfs-idmapped-mounts.h |  15 ++
>>   src/vfs/utils.h                 |   2 +
>>   src/vfs/vfstest.c               |  13 +-
>>   tests/tmpfs/001                 |  27 +++
>>   tests/tmpfs/001.out             |   2 +
>>   tests/tmpfs/Makefile            |  24 +++
>>   8 files changed, 389 insertions(+), 3 deletions(-)
>>   create mode 100644 src/vfs/tmpfs-idmapped-mounts.c
>>   create mode 100644 src/vfs/tmpfs-idmapped-mounts.h
>>   create mode 100755 tests/tmpfs/001
>>   create mode 100644 tests/tmpfs/001.out
>>   create mode 100644 tests/tmpfs/Makefile
>>
> 
> [snip]
> 
>> diff --git src/vfs/tmpfs-idmapped-mounts.h src/vfs/tmpfs-idmapped-mounts.h
>> new file mode 100644
>> index 00000000..038d86a9
>> --- /dev/null
>> +++ src/vfs/tmpfs-idmapped-mounts.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __TMPFS_IDMAPPED_MOUNTS_H
>> +#define __TMPFS_IDMAPPED_MOUNTS_H
>> +
>> +#ifndef _GNU_SOURCE
>> +#define _GNU_SOURCE
>> +#endif
>> +
>> +#include "utils.h"
>> +
>> +extern const struct test_suite s_tmpfs_idmapped_mounts;
>> +
>> +#endif /* __TMPFS_IDMAPPED_MOUNTS_H */
>> +
>     ^^
> A blank line at EOF

Removed, thanks!

> 
> 
>> diff --git src/vfs/utils.h src/vfs/utils.h
>> index f1681737..872fd96f 100644
>> --- src/vfs/utils.h
>> +++ src/vfs/utils.h
>> @@ -45,6 +45,8 @@
>>   #define DIR2 "dir2"
>>   #define DIR3 "dir3"
> 
> [snip]
> 
>> diff --git tests/tmpfs/Makefile tests/tmpfs/Makefile
>> new file mode 100644
>> index 00000000..b464b22b
>> --- /dev/null
>> +++ tests/tmpfs/Makefile
>> @@ -0,0 +1,24 @@
>> +#
>> +# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
> 
> Is the copyright what you want?

Heh, no. I'll correct it, thanks!

> 
>> +#
>> +
>> +TOPDIR = ../..
>> +include $(TOPDIR)/include/builddefs
>> +include $(TOPDIR)/include/buildgrouplist
>> +
>> +GENERIC_DIR = generic
>> +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GENERIC_DIR)
> 
> Above two lines are wrong, that'll cause tmpfs/001 can't be installed correctly.
> You can change them to:
>    TMPFS_DIR = tmpfs
>    TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(TMPFS_DIR)

Oh, I haven't tried the install. Fixed this now, tested it with a 
different prefix and seems to work fine.



Best,
Rodrigo
