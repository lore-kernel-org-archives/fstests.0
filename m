Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F248C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 17:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFDF61157
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 17:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhEYRgM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhEYRf6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 13:35:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A16C061574
        for <fstests@vger.kernel.org>; Tue, 25 May 2021 10:34:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b9so13405071ejc.13
        for <fstests@vger.kernel.org>; Tue, 25 May 2021 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXOZOQCW62nbEWwg88fBR9W9+g0xMNw6RYr2fQ6h3wY=;
        b=NaIHjkgRntK+wdGCuh+DqTpivnGBp5pvt18+Rto6YyHYthv+QCjHeDMVJbocNBJpGu
         LnYUdnumaflJkhJRhDx9qdJsAsYrcQ0857OuWifZbNx5cGXZFH23WQjHpFn4wteLKRjD
         KM6NYL5uEYruzKxRc8oEkRAKD5kN8Fx9c2HuzR2ZLtpQkskXDSUAhMk+ugX1FhmJk0N4
         VtwCJa+6XWc+WZulXGk8IMLMbw/D9yu2VUL3a4lwRLYAIMzYJ8aqw5o3iLqf4G+5SUKi
         cu86LOGmaCqaO2kmnCE+9y5J73N6DlT+V21jYHcw7SvEdk+MvFK3x1rBCAFpBZA2Fo72
         OpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXOZOQCW62nbEWwg88fBR9W9+g0xMNw6RYr2fQ6h3wY=;
        b=RTXRBqak+FU5uiyEH6/WQLh4GgoD/BbkyJAR9QBvCcw+yyKJtfFDT9+94vf1OXflyp
         3zVrbOVqpMGJ1UlZtnwOy7kdmxddVRX3mdhZOJn8EK0ThFyjVKmt8VtgvY4LIJHYxYyR
         DVYpRd1Kq2OX+uaeIHlfdUBc+XrRd+1QN09e18r8V7WD3cEI2sRRyt7F8XRtb0k8T/Bp
         qGpkU50XhgfigNM5cP17GzdUQD+kyO+sLTkcIa7w3Q2dZG6uhMZAUY6BdOCmT0mYkRqg
         3ckJVvPkuSB5fW8A2ytRvaz68Odvrw4Y79b31HW9iWaMyZibOgnu3wMCxGZ6lgaiIcxp
         oe/A==
X-Gm-Message-State: AOAM533DwGquP4HdNvEHNzacDJbPK6uZDyxWrCYM9uwnJDWvZoSQ6lOT
        hROTVzUUQjjYIXust90dg9Pb2z+jQOM5b8VCI9g=
X-Google-Smtp-Source: ABdhPJz2h3LjdSZJimBkeJv7e1fU2FvgDlv0HNvtljB205emtqsgLhBbpZJaZLaLBFdNrHSQjXjLLqvkvb1DSgvEUG0=
X-Received: by 2002:a17:906:174e:: with SMTP id d14mr308374eje.397.1621964065128;
 Tue, 25 May 2021 10:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210522184814.95802-1-jakobunt@gmail.com> <YKoa7dtkdmu8hp+/@desktop>
In-Reply-To: <YKoa7dtkdmu8hp+/@desktop>
From:   Jakob Unterwurzacher <jakobunt@gmail.com>
Date:   Tue, 25 May 2021 19:34:14 +0200
Message-ID: <CAPv9ZmkirKWThgE7q2oHFFMtk0bQ7A9xG8i+RGqgyLnCkCJJZg@mail.gmail.com>
Subject: Re: [PATCH] generic/286: fix integer underflow on block sizes != 4096
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 23, 2021 at 11:05 AM Eryu Guan <guan@eryu.me> wrote:
> The total read length should be
>
> "The length of this extent is (hole_off - data_off)"
>
> according to the comments above do_extent_copy(). Total read length
> being not a multiple of 4k means 'data_off' or 'hole_off' is not 4k
> aligned.

That is correct.

> But generic/286 creates source files with length of all data extents and
> hole extents being multiple of 4k. So I still don't understand why this
> is valid for gocryptfs. Shouldn't that be a bug in seek_data/seek_hole
> in gocryptfs? Could you please elaborate?

Yes sure, the situation is a bit complicated. gocryptfs works similar
to eCryptFS and EncFS (also overlay filesystems).
The files are stored in encrypted form in regular files on ext4 or xfs
or whatever "real disk" filesystem.
Disk space allocation & file holes are handled by the real filesystem.
A gocryptfs mount shows a decrypted view of these files.

Now, gocryptfs uses AES-GCM for encryption. This adds 32 bytes of
overhead to every 4096-byte block,
which gives a storage size of 4128 bytes.

The encryption overhead is why the files & holes created by
generic/286 are not 4k-aligned on disk when viewed through the
gocryptfs mount.

Thanks, Jakob
