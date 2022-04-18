Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1C4C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Apr 2022 15:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiDRP6k (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346433AbiDRP6U (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Apr 2022 11:58:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069722BE
        for <fstests@vger.kernel.org>; Mon, 18 Apr 2022 08:50:51 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q75so2794856qke.6
        for <fstests@vger.kernel.org>; Mon, 18 Apr 2022 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orA4QE2APH4vOV9hjMJHV1gzTkiPxnNssNILtH/hM7c=;
        b=pkSq6I4t0du+2nf6bbUkc6leINoRS7nxGm6BGpKNT6q8HhDRkvcQ0AQShkZQXOg+to
         52OE4PKsFxPVpRBIELP62oZ8XC9wM3yhnqvdsAXs2p7JCYAWrkA1uGfS7xKip0uLMrre
         VIX5/FhImFuHHEYN/jocO+5OtWxOiK0Bk4AjQfRB56x45h4I6K47tqxfB9tQUgy1VhlU
         mF12ta8+sC7sRrJWPRSgNc0ifhEFC0m7whZpAfLpatDBdP55WbWUa/kFgytYp+Uatrka
         F3xzdfhwgR2FpLn/BrATKoIp/44N4G0E4wkT2HAP/jP0zggt/OcZCrT5Bgt6W6SI+ZaZ
         c+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orA4QE2APH4vOV9hjMJHV1gzTkiPxnNssNILtH/hM7c=;
        b=sE4DsD3KwTnPoVehtYvjbAUJ+mP25X6Lk8+YgwsKNmcL0+ND9G/nBsbkv5QsWxjbLP
         +NOwKpC1KI/lUjbeObZeeRgsxxuNqbxgUR1Cndv+i2QygbV+ZEz5V2Kgu8F1eyoKk/U9
         1tXFLkeEqKXYhzwoNs8SSRr4ieg5/HjEYAShus5HifDYGdclFmlXNrQ7uflwVbMxrU6q
         KiFcTmL4L7KNYHlZ33MXTRCdO/361klXujj2Rpc0KXtnnVQSK5lY0tHjGLailXTRQBma
         fPp3i23bsRhc2bC951TL/MiYX5YmrdXf8hYnUDlS0vlplaTyhSwkGKJqKTEtXBy0e5ld
         XoDQ==
X-Gm-Message-State: AOAM533zcaFcu+EqYOEA7xnQBsC9o7f1tWBSlLf/NG165McgIJzQ/bJO
        yH/BuGNQT5Q4t7afMx5AyVH5XmKM/C4i8Po1i0c=
X-Google-Smtp-Source: ABdhPJyrp/HB4EmKMyXNDlPzVg6XLdE7i5H6tIl5wYE5fLyUswszh29/oic56D09Rl3WwwdhRT3AoRadxTAS4y42qnk=
X-Received: by 2002:a05:620a:1a87:b0:69e:bd47:7285 with SMTP id
 bl7-20020a05620a1a8700b0069ebd477285mr349840qkb.19.1650297050131; Mon, 18 Apr
 2022 08:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220417174023.3244263-1-amir73il@gmail.com> <20220417174023.3244263-3-amir73il@gmail.com>
 <20220418045226.tjzfcerypfmwybh6@zlang-mailbox> <CAOQ4uxign3xse8nQeE7OHz8=99igQir-EM0Tga4G_5uii1PvVw@mail.gmail.com>
 <Yl2BYBA1aPtQRA9p@mit.edu>
In-Reply-To: <Yl2BYBA1aPtQRA9p@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Apr 2022 18:50:38 +0300
Message-ID: <CAOQ4uxhS4YfDW9CtG4Wc0ZzZKd80W6NHmSe0zd+ZzJ6nocz=2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] common: print hints for reasons of test failures
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 18, 2022 at 6:19 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Apr 18, 2022 at 08:26:33AM +0300, Amir Goldstein wrote:
> > >
> > > The _fixed_by_kernel_commit is fine, just not all cases for kernel patch,
> > > some of them cover patch from userspace packages. So you might change it
> > > to _fixed_by_upstream_commit, then let its arguments point out the commit
> > > from which upstream project.
> >
> > I thought about it too and I agree we should have _fixed_by_upstream_commit
> > In fact, LTP tests are annotated like this: {"linux-git", "8edc6e1688fc"}.
>
> Sometimes there will be a different fix for stable kernels because the
> "proper" fix in upstream is too risky / dangerous / involved.  So it
> might be useful to specify multiple commits.
>

multiple hints are supported, see:

tests/overlay/074:_fixed_by_kernel_commit 144da23beab8 \
tests/overlay/074      "ovl: return required buffer size for file handles"
tests/overlay/074:_fixed_by_kernel_commit 9aafc1b01873 \
tests/overlay/074      "ovl: potential crash in ovl_fid_to_fh()"

> > But I decided that even if and when we add _fixed_by_upstream_commit
> > we had better leave the wrapper _fixed_by_kernel_commit for brevity
> > because it is by far going to be the most used annotation.
> > I can add this helper now or it could be added later.
>
> Maybe allow multiple _fixed_by_kernel_commit where the default is
> upstream, and then other git trees can be specified?  e.g.:
>
> _fixed_by_kernel_commit 8edc6e1688fc
> _fixed_by_kernel_commit deadbeef1234 linux-5.4
> _fixed_by_kernel_commit f00dfeed5678 linux-5.10
>

All the args are just free text printed as hint, so you could
write it as:

_fixed_by_kernel_commit 8edc6e1688fc \
       "fanotify: fix notification of groups with inode & mount marks"
_fixed_by_kernel_commit deadbeef1234 linux-5.4 \
       "[5.4 backport] fanotify: fix notification of groups with inode
& mount marks"

Which results in:

HINT: You _MAY_ be missing kernel fix:
    8edc6e1688fc fanotify: fix notification of groups with inode & mount marks

HINT: You _MAY_ be missing kernel fix:
    deadbeef1234 [5.4 backport] fanotify: fix notification of groups
with inode & mount marks

Thanks,
Amir.
