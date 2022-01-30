Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B050C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Jan 2022 15:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347326AbiA3PH0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Jan 2022 10:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347340AbiA3PH0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Jan 2022 10:07:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C974C061714
        for <fstests@vger.kernel.org>; Sun, 30 Jan 2022 07:07:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 58DFDCE0F5A
        for <fstests@vger.kernel.org>; Sun, 30 Jan 2022 15:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114C3C340E4;
        Sun, 30 Jan 2022 15:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643555241;
        bh=klFqchxKLw4hTxGaeFm119hrvJki1R7D+mAOGUs4QWc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=kDtPv6F1826BenDXsTvtuMiga4Np4RZlJY3O7Yy2QbV9RJZ2J85wxs2tzwMRAt03b
         xO0cMFaZ8sO/kFB4kicIXzPsHB5v1zv9iKLcV5yirA5uI3HvaL0wQNmKaNchbEywo3
         tWqXX5QPMa5vufBOXeB6w0LcLr893wlj5et7DGPIihyRgPoZWPokPtJOdOZbg6MKtU
         rbQbdTLpJqkYe9AAdi9ordhFGPwXX6T6hjewWdYzJIeq4oy0s9CJS5cPn0TQpy3WEc
         lW7p3eGOZGoL0y0UkCHDqjG4Q9BpJZGx/7t7w1lVgzxwqWoO+EJ+llQ35+i7/6t1yQ
         O0h8Ow0it/J+w==
Message-ID: <6dbebe97-b29d-ede4-79cf-4d66b2d44c01@kernel.org>
Date:   Sun, 30 Jan 2022 23:07:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] common/attr: _acl_get_max echo 532 for f2fs
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org, guan@eryu.me
References: <20220130092858.1260210-1-sunke32@huawei.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220130092858.1260210-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/1/30 17:28, Sun Ke wrote:
> Run generic/026 on f2fs, the diff:
> 
>      -chacl: cannot set access acl on "largeaclfile": Argument list too long
>      +Wrong ACL count - 532 != 531
> 
> The ACL_MAX_ENTRIES depend on MAX_VALUE_LEN(inode), MAX_VALUE_LEN(inode) I got
> by printk is 4244, so I think the ACL_MAX_ENTRIES should be
> (4244 - 20) / 8 + 4 =532.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>

FYI:

https://patchwork.kernel.org/project/fstests/patch/20170428131307.3384-1-chao@kernel.org/

I've update the patch based on Jaegeuk's comments, however, I forgot to send it to
mailing list, so could you please check revised one below?

 From 68965c837fd04795064b352589e3f7005e6d75f5 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Fri, 28 Apr 2017 20:51:11 +0800
Subject: [PATCH v2] attr: adbjust acl_max of f2fs

f2fs has set inline_xattr as a default option, and introduced a new option
named 'noinline_xattr' for disabling default inline_xattr option. So in
_acl_get_max we need to check 'noinline_xattr' string in fs option,
otherwise we may select the wrong max acl number since we always found
the string 'inline_xattr' in fs option.

Additionally, f2fs has changed disk layout of xattr block a bit, so will
contain one more entry in both inline and noinline xattr inode, this patch
will modify the max acl number to adjust it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- adjust the config for old kernel as well.
  common/attr | 11 ++++++++---
  1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/common/attr b/common/attr
index 35682d7c..6377a936 100644
--- a/common/attr
+++ b/common/attr
@@ -26,11 +26,16 @@ _acl_get_max()
  		echo 8191
  		;;
  	f2fs)
-		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
+		_fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
  		if [ $? -eq 0 ]; then
-			echo 531
+			echo 507
  		else
-			echo 506
+			_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
+			if [ $? -eq 0 ]; then
+				echo 532
+			else
+				echo 507
+			fi
  		fi
  		;;
  	bcachefs)
-- 
2.32.0
