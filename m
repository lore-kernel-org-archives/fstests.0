Return-Path: <SRS0=zAcK=AQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CC8C433E0
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Jul 2020 11:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937A520771
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Jul 2020 11:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnvQJoM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGEL2p (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Jul 2020 07:28:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45734 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726454AbgGEL2p (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Jul 2020 07:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593948523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/rCPhGvsGdrOCSeVxjZXiZ2UsWsYquFqzxFjwXFQIGw=;
        b=OnvQJoM2XXgpfiYkk5qGy8Sk/UjOccB//a4HY/lyuZpWkEQnchk7wMCccaUREEYYW8c+YG
        JOfDbs2y6JjFxbAXpQQ4vDwC6DPqFHA1d3b/y82pRVdpm/Fo8t2do663DdekZaqSGjx7O8
        ofhgFRcsxMl/zZX3qZQ2eOuezNQSdec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-ldbt0eBVNkqfJgbVVxEo2A-1; Sun, 05 Jul 2020 07:28:40 -0400
X-MC-Unique: ldbt0eBVNkqfJgbVVxEo2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D51B31005510;
        Sun,  5 Jul 2020 11:28:39 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EE5AC0DBA;
        Sun,  5 Jul 2020 11:28:39 +0000 (UTC)
Date:   Sun, 5 Jul 2020 19:41:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/377: filter out xattrs that don't start with
 'user.'
Message-ID: <20200705114113.GS1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org
References: <20200701175205.342650-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701175205.342650-1-jlayton@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 01, 2020 at 01:52:05PM -0400, Jeff Layton wrote:
> Most hosts that I've been testing on seem to display security.selinux in
> listxattr. 377.out doesn't account for that so it routinely fails for me
> in testing.
> 
> When testing the output of listxattr in generic/377, filter out any xattr
> names that don't start with 'user.'. That should help ensure consistent
> output on SELinux-enabled hosts.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Yeah, I hit this error[1] too. This patch looks good to me.

One more question, do you hit similar failure on generic/062, likes [2]? 

Thanks,
Zorro

[1]
--- /dev/fd/63	2020-07-02 12:07:42.948327419 -0400
+++ results/generic/377.out.bad	2020-07-02 12:07:41.990305624 -0400
@@ -1,4 +1,5 @@
 QA output created by 377
+xattr: security.selinux
 xattr: user.foo
 xattr: user.hello
 xattr: user.ping
...

[2]
--- /dev/fd/63	2020-07-02 07:15:09.072853920 -0400
+++ results/generic/062.out.bad	2020-07-02 07:15:08.156833194 -0400
@@ -52,6 +52,7 @@
 SCRATCH_MNT/reg: user.name2: No such attribute or operation not permitted
 *** final list (strings, type=reg, nsp=user)
 # file: SCRATCH_MNT/reg
+security.selinux=0x73797374656d5f753a6f626a6563745f723a6e66735f743a733000
 user.name=0xbabe
 user.name3=0xdeface
...

>  tests/generic/377 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> I'm not sure why this doesn't fail for most people, unless most are
> turning off SELinux. Is this the right approach?
> 
> diff --git a/tests/generic/377 b/tests/generic/377
> index f7835ee8ff9e..f08abdca60a6 100755
> --- a/tests/generic/377
> +++ b/tests/generic/377
> @@ -48,7 +48,7 @@ $SETFATTR_PROG -n user.ping -v pong $testfile
>  $SETFATTR_PROG -n user.hello -v there $testfile
>  
>  # 1. Call listxattr without buffer length argument. This should succeed.
> -$listxattr $testfile | sort
> +$listxattr $testfile | grep '^xattr: user\.' | sort
>  
>  # 2. Calling listxattr on nonexistant file should fail with -ENOENT.
>  $listxattr ""
> @@ -66,7 +66,7 @@ $listxattr $testfile 9
>  $listxattr $testfile 11
>  
>  # 6. Calling listxattr with buffersize bigger than needed should succeed.
> -$listxattr $testfile 500 | sort
> +$listxattr $testfile 500 | grep '^xattr: user\.' | sort
>  
>  status=0
>  exit
> -- 
> 2.26.2
> 

