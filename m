Return-Path: <SRS0=fGqU=YR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A0CCA9EAF
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Oct 2019 21:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516D321928
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Oct 2019 21:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BufjZUo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfJXVCU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:02:20 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34079 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfJXVCT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Oct 2019 17:02:19 -0400
Received: by mail-yw1-f65.google.com with SMTP id d192so73928ywa.1;
        Thu, 24 Oct 2019 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIH6epXrmFekocIUDBH12XrVhDptTinR3TD95GnM654=;
        b=BufjZUo5lMW6dTec6f7EmHoS+j3DoFeT5PqN0N8fHzjPOu4enu2mHdF6QlCbIQVGD3
         2nA/WXEdXXCW99W9BOEr4VFmycWPoMGsPbDY/rJAzjCCnPlCMI5btxS/4G1ERLkPr81S
         GFaYortPQDSTgTFrJdiE7I+asaDz5mnx0YoZMBLSQDkDT0WOlzbuRNTI9Hi5/xQ2OmLU
         c9iBqqj4vDDTR/1M6y5ydFzHavjySj/W4otx0pQ6gi4yWj1wTsN5EUoMf+ioLoh9Kjio
         vD3pvnscDQCWYtSH3P83DTppp1xFvajXlOlwI5XMELLpe4zK6xqLIwYMy1JzFSWGwi7F
         nvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIH6epXrmFekocIUDBH12XrVhDptTinR3TD95GnM654=;
        b=fFBz/bfSDNF2PdrEZInBnhJXZGwSqm2SFN+4TBQebpAheDYNK9gyCG2UqMnHjVV8VZ
         8x+MkFPDuGK2W0NA2TzFz6UBkBm35sewL+5MjLfEBROOXhRka3xQfmVgy2OKK525QeIf
         KA+sadgJUwfP2Kzi/sPBL1FyUqamFHUnxC/JdO0oNTHe4R7u8rDuI8pJpRf5ma2bC4n5
         JET29K2zZ9DcD7pfvwftFFyEclPu8iIrx+9YBm7d/fwDLrLcl1HDEfd9eKmi6LhCEjHa
         uWl1c8eRlkR3xkX9OsGHPoC3xo2d3X4efTsLnM+VVYykL7lTwqhoDpjMPMiaYSk9Z7/u
         1k0w==
X-Gm-Message-State: APjAAAUmAfoKr3WxclNmxDDBNkOPmWLyGMUmUMuPLx1oMFhkRACJAMcW
        dPzYQsFyaAigDj9rL7Rh7+V5KALf3vT8QXFxSCQ=
X-Google-Smtp-Source: APXvYqy5z/TP7LPuVgQ1SCzR5Umw8A+Zx8bm2sIRdpCjds94gknoNNPZh/TYdjnXTVOjast3WFE9Y8IKH/cgyuIvhPc=
X-Received: by 2002:a81:4a02:: with SMTP id x2mr8312228ywa.31.1571950938628;
 Thu, 24 Oct 2019 14:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191024122923.24689-1-cgxu519@mykernel.net>
In-Reply-To: <20191024122923.24689-1-cgxu519@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 25 Oct 2019 00:02:07 +0300
Message-ID: <CAOQ4uxidZ=g29hGmKxinRA4Gp6CiWbOB9RqLWPPFXwtCB4DWog@mail.gmail.com>
Subject: Re: [PATCH v3] overlay/066: copy-up test for variant sparse files
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     fstests <fstests@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 24, 2019 at 3:29 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> This is intensive copy-up test for sparse files,
> these cases will be mainly used for regression test
> of copy-up improvement for sparse files.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>
> ---
> v1->v2:
> - Call _get_block_size to get fs block size.
> - Add comment for test space requirement.
> - Print meaningful error message when copy-up fail.
> - Adjust random hole range to 1M~5M.
> - Fix typo.
>
> v2->v3:
> - Fix space requiremnt for test.
> - Add more descriptions for test files and hole patterns.
> - Define well named variables to replace unexplained numbers.
> - Fix random hole algorithm to what Amir suggested.
> - Adjust iosize to start from 1K.
> - Remove from quick test group.

Why? you said it takes 7s without the kernel patch.
The test overlay/001 is in quick group and it copies up 2*4GB
sparse files.

Tests that are not in quick group are far less likely to be run
regularly by developers.

Otherwise looks good.

Thanks,
Amir.
