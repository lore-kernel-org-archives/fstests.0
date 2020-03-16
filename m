Return-Path: <SRS0=PVdF=5B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041E0C4CECE
	for <linux-fstests@archiver.kernel.org>; Mon, 16 Mar 2020 12:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BBE20719
	for <linux-fstests@archiver.kernel.org>; Mon, 16 Mar 2020 12:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iMuvtRM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgCPM3F (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:29:05 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36425 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730896AbgCPM3F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Mar 2020 08:29:05 -0400
Received: by mail-il1-f194.google.com with SMTP id h3so16301219ils.3
        for <fstests@vger.kernel.org>; Mon, 16 Mar 2020 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZGGRuaKQhMX4px0JtkjJt8BcVaQIFCUr3KcXBU9aDQ=;
        b=iMuvtRM+LzR43x5s93l6b2B8+QyQA2vs1aaX/ZOXi/CSlZglWwdxKHgQ6aeuqiIlal
         FY/U6gtTO3YJ6gbYLHDDrtdNlCC2u11bZd0/db1gwsATYgjpFhfR2ObBCPgzmnZwgIKh
         bAtCEN+20RBvwYijKtp98myROfLY3PKcl7uas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZGGRuaKQhMX4px0JtkjJt8BcVaQIFCUr3KcXBU9aDQ=;
        b=grbULhnVjoNtr9RGBADeMskXnykrHH2OpM6PwnjIy8T5RXLFl+4ZV1JetvbDLpyywe
         1Ly/Po5hWZu77+P5DDUOP3Q2bJDM8/qe0a3AjLkXUBsl9zHNg7gWnznLubB9lCNGOkr/
         O4686/BMm6NlsJn8u+FMid9TnD0r0BSADFkZQiYXN6nPbkRTLJmn26OPUq8APL++jefC
         F9zRVUyRXAHUc0nz5ZXTYMDdN0XF4Jz5wP4s7885D4NNOLNzmIxrsul0mDr/lzWR1xHs
         v1PtAuI2Yl8IPTfusI8tcmp0cmW2JYW0Bho16E0rWCTe280SIM09O1ZfG1CiSdVFZXfT
         HcDQ==
X-Gm-Message-State: ANhLgQ1bdt6Zbk6EDuQYZm36vvi8PnwgCSBPMW3yLTGs+1QYA37ZePiR
        3p00ywqNNjPkeXAid8ntRC132mCpleUo1HSYoNvUSA==
X-Google-Smtp-Source: ADFU+vtrBIgdSTTlk46pFKF0XyNxSc2KxQlr6YZr+ZUSgjGGY3I2Um+kkJsTWw/BCGzuID3YwIxaetmqr78F8Z/kbZA=
X-Received: by 2002:a92:aa87:: with SMTP id p7mr25070122ill.63.1584361744244;
 Mon, 16 Mar 2020 05:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191230141423.31695-1-amir73il@gmail.com> <20191230141423.31695-5-amir73il@gmail.com>
In-Reply-To: <20191230141423.31695-5-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 16 Mar 2020 13:28:53 +0100
Message-ID: <CAJfpegvHAq+yT1qW4JqTBpviCHUrQqOPMfWEcvhy4Jpr2bLJfQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] overlay: test constant ino with nested overlay
 over samefs lower
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 30, 2019 at 3:14 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Also test that d_ino of readdir entries and i_ino from /proc/locks are
> consistent with st_ino and that inode numbers persist after rename to
> new parent, drop caches and mount cycle.

overlay/070 and overlay/071 fail for me like this:

     QA output created by 071
    +flock: cannot open lock file
/scratch/ovl-mnt/lowertestdir/blkdev: No such device or address
...

I.e. there's no block dev with rdev=1/1.

I don't see any other way to fix this, than to remove the device
tests.  Why are these needed?  Is locking code in any way dependent on
file type?

Thanks,
Miklos
