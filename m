Return-Path: <SRS0=Q9mn=YL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F2DCA9EA1
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Oct 2019 10:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F172064B
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Oct 2019 10:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6clg3pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405204AbfJRKY1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:24:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41268 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJRKY1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Oct 2019 06:24:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so3595963pfh.8
        for <fstests@vger.kernel.org>; Fri, 18 Oct 2019 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bQ2cMg+OWBiFlRgMrMFZXEjrXRo6h6y5koq1ug6dfX8=;
        b=k6clg3paJnHTLuRuQ1nUBZynVADTSLOE3ClUbfkbtWSFTOdVdsDnAYqzrhd6ujhDPU
         Q+g3iu6niTA0RScxyXW8+CtGlRLmrLEa1MdpdmjLJbM3tRtuxcifTZ3FweukogdkP+vV
         thEZYuVCBcnZ9bmoqXBteqN4zFm1fiZFhvLblZ4YmhUGCU4UXF9tScovfLyxh3sDyDEu
         g0+LTlJDagamZlbRQmyJxF4VzqX6wRFwgMTU9xfiyFqGeQgel3ri3+qcX3oc3Pevabn6
         Lx39Iem5ZFIGgtSWhy3My9lJAZMLuD7OGQ0WehSIVdgTcRnXx06QC0RfNnnJJpmo5Jfq
         cgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bQ2cMg+OWBiFlRgMrMFZXEjrXRo6h6y5koq1ug6dfX8=;
        b=Z5HbC74yBKp0qyKo+o7nGKpzTw+sAsGj76S7htXMubLkbt/BzEeLlewpKedIPfQ/aW
         s7r4JOeVj20J9JjFynUaIWK9iLkke2g0WLAbIh4uXR/zF2t5FHHeQR4QzBZPwAkBZGD6
         XfWUsRzfh5zZI6u8uK18x7WmwzGCmndPgJWXA//sjqhbiKyQ4ccLtVKn92YQkp/aPdZS
         QEzlLRviKXi1Zw3ccMuVtJsvG4O4MLv0kYJ6eFsKR7R/hRs0R/3tnCs8FHI7PZ4TIsPF
         IMMyHpafZS3KujnblXXHKDBDYbSbjRl2yXp1G9UmKQIyFDWBqoO6hcDvFU2U9/pur8fj
         Be2g==
X-Gm-Message-State: APjAAAVW2fLtkK0tAiTyySWqNYlmQG6cr4uJQvFVS6yl3Qct2tnMaTBt
        sFaqLKxuNS7VvAoR5FBB/tg=
X-Google-Smtp-Source: APXvYqxC84iMyVAX5ryUcc1UrchltL2wuQLZUg4Z/9wva7vPQrpsXWkr5cWetrHrFv26rWPaEJepnA==
X-Received: by 2002:a63:1e5f:: with SMTP id p31mr9069781pgm.291.1571394265209;
        Fri, 18 Oct 2019 03:24:25 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id q2sm11504118pfg.144.2019.10.18.03.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 03:24:24 -0700 (PDT)
Date:   Fri, 18 Oct 2019 18:24:17 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
Message-ID: <20191018102417.GN2622@desktop>
References: <20191016105347.16650-1-misono.tomohiro@jp.fujitsu.com>
 <20191018083951.GJ2622@desktop>
 <OSBPR01MB3783B9C166C06784BF5C7385E56C0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB3783B9C166C06784BF5C7385E56C0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 18, 2019 at 09:02:12AM +0000, misono.tomohiro@fujitsu.com wrote:
> > On Wed, Oct 16, 2019 at 07:53:47PM +0900, Misono Tomohiro wrote:
> > > This test requires fallocate keep_size. So, skip the test if a target
> > > FS does not support the function to avoid false negative.
> > >
> > > Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > 
> > Would you please paste the false failure you've seen? I can't recall I hit such failures, and I think fsx would just disable unsupported
> > operations and don't cause failure, it just prints a message to stderr, and we already redirect stderr to $seqres.full in run_fsx
> > in 469.
> 
> Hi, I just got output mismatch error:
> 
> $ cat results/generic/469.out.bad
> QA output created by 469
> fsx --replay-ops fsxops.0
> Seed set to 1
> main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, disabling!
> main: filesystem does not support fallocate mode FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, disabling!
> main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, disabling!
> main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, disabling!
> main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
> main: filesystem does not support clone range, disabling!
> main: filesystem does not support dedupe range, disabling!
> fallocate: 0x0 to 0x1000
> do_preallocate: fallocate: Operation not supported
> LOG DUMP (1 total operations):
> 1(  1 mod 256): FALLOC   0x0 thru 0x1000        (0x1000 bytes) PAST_EOF
> Log of operations saved to "/test1/469.fsx.fsxops"; replay with --replay-ops
> Correct content saved for comparison
> (maybe hexdump "/test1/469.fsx" vs "/test1/469.fsx.fsxgood")

Ah, I recalled that I actually tried to fix this issue before, but Amir
didn't like my patch back then :)

https://spinics.net/lists/fstests/msg07953.html

Because my patch silently ignored 'keep_size' flag when replaying
operations, and look at it again, I don't like it either.

I think we could just skip the keep_size operations instead of ignoring
it.

Would you please try this patch?

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 06d08e4e93f3..ae89bf665db4 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2044,6 +2044,9 @@ have_op:
                if (!fallocate_calls) {
                        log4(OP_FALLOCATE, offset, size, FL_SKIPPED);
                        goto out;
+               } else if (keep_size && !keep_size_calls) {
+                       log4(OP_FALLOCATE, offset, size, FL_SKIPPED | FL_KEEP_SIZE);
+                       goto out;
                }
                break;
        case OP_PUNCH_HOLE:
@@ -2056,6 +2059,9 @@ have_op:
                if (!zero_range_calls) {
                        log4(OP_ZERO_RANGE, offset, size, FL_SKIPPED);
                        goto out;
+               } else if (keep_size && !keep_size_calls) {
+                       log4(OP_ZERO_RANGE, offset, size, FL_SKIPPED | FL_KEEP_SIZE);
+                       goto out;
                }
                break;
        case OP_COLLAPSE_RANGE:

Thanks!

Eryu
> 
> Thanks.
> 
> > 
> > Thanks,
> > Eryu
> > 
> > > ---
> > >  tests/generic/469 | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tests/generic/469 b/tests/generic/469 index
> > > 47fdf0cf..0c6f8ae5 100755
> > > --- a/tests/generic/469
> > > +++ b/tests/generic/469
> > > @@ -40,6 +40,7 @@ rm -f $seqres.full
> > >  _supported_fs generic
> > >  _supported_os Linux
> > >  _require_test
> > > +_require_xfs_io_command "falloc" "-k"
> > >
> > >  run_fsx()
> > >  {
> > > --
> > > 2.21.0
> > >
