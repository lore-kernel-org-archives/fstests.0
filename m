Return-Path: <SRS0=rTp8=5D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F52C1975A
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Mar 2020 02:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FA720724
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Mar 2020 02:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCRCK0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 Mar 2020 22:10:26 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36309 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbgCRCK0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Mar 2020 22:10:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TsvBXl6_1584497418;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0TsvBXl6_1584497418)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Mar 2020 10:10:18 +0800
Date:   Wed, 18 Mar 2020 10:10:18 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Paulo Alcantara <pc@cjr.nz>
Cc:     Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic/310: slightly improve check for dmesg error
Message-ID: <20200318021018.GG47669@e18g06458.et15sqa>
References: <20200317015439.7406-1-pc@cjr.nz>
 <20200317105544.GF14282@dhcp-12-102.nay.redhat.com>
 <85k13jron9.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85k13jron9.fsf@cjr.nz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 17, 2020 at 12:23:38PM -0300, Paulo Alcantara wrote:
> Zorro Lang <zlang@redhat.com> writes:
> 
> > On Mon, Mar 16, 2020 at 10:54:39PM -0300, Paulo Alcantara (SUSE) wrote:
> >> The 'grep -c "error"' check was causing false positive results for
> >> cifs.ko when running it with 'echo 1 > /proc/fs/cifs/cifsFYI'.
> >> 
> >> That is, the test would fail when cifs.ko prints out a non-error
> >> message like this:
> >> 
> >>   [ 2320.903987] fs/cifs/smb2maperror.c: Mapping SMB2 status code
> >>   0x80000006 to POSIX err -61
> >> 
> >> Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
> >> ---
> >>  tests/generic/310 | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/tests/generic/310 b/tests/generic/310
> >> index 1fcd517e4e6f..504f7c44c177 100755
> >> --- a/tests/generic/310
> >> +++ b/tests/generic/310
> >> @@ -49,7 +49,7 @@ _require_command "$KILLALL_PROG" killall
> >>  dmesg -c > /dev/null
> >>  
> >>  nr_bug=`dmesg | grep -c "kernel BUG"`
> >> -nr_error=`dmesg | grep -c "error"`
> >> +nr_error=`dmesg | grep -c "EXT[234]-fs error"`
> >
> > This's a generic test, which is not only for extN filesystem. If only for
> > "fs/cifs/smb2maperror.c: Mapping SMB2 status ...", how about:
> >    grep -wc "error"
> > or
> >    grep -c "\berror"
> >
> > or something better:)
> >
> > I think it still works for "EXT3-fs error (device loop1): ext3_readdir:
> > bad entry in ....".
> 
> Both look good to me. Thanks for pointing it out!
> 
> Eryu,
> 
> Do you want me to resend or you can just apply one of above suggestions?

This change seems easy enough, I can fix it on commit. Thanks!

Eryu
