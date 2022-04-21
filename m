Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8D8C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Apr 2022 07:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386238AbiDUHzl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386240AbiDUHzk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Apr 2022 03:55:40 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE098E023
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 00:52:46 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id n11so3167283qvl.0
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 00:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOoq1Dw70BqaJpBuXdOQimG7lWwYwwMAiP34ptDfBAg=;
        b=pnrWCZG4wW1fB+tLRVj2R99rG8O0oYVyLWqUaJ4yjJpCzBUWrafeDUGcfPOB1tlgRI
         QCeuuLsi1QL2gv0yZG+NoE9iOR5oXXxVHYX2cOfiI4CrHGhuRItHHYicyXFHksnPKUm1
         HYHSqQzvppcwBIfA8jMFkrlvQ49AlFmzGjXhMUYtFRytgjsia8/29e1MDjP4ADQMoM6H
         eONbeJYdam9n7/zCVvIcqCLa7UW1HNToRvFjeMLsQ80yjLha1d3G9HvhOT7wLPxt+xwM
         QtTiqsF8LgtzyCm/yLRRjxeB4aDZUUv3Mw97lyaXAH7T3CDgqacXiqN8iSPATTgvsQXH
         xBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOoq1Dw70BqaJpBuXdOQimG7lWwYwwMAiP34ptDfBAg=;
        b=L5Z8lFJHdXUQlkAj11X8cbGAHywhJwjp1+zvc4B9Iux0Pw9kC4QdJHW3Qnd0P9Jvbd
         HJ3kCDKRnVomYGQik+JVmBfyH4lIj5hO8EJb7Y6ktXoyADhp/nO/xQetoqs+3E9dC4U6
         1ESDHaLG8nQkn9vNxmkyS3jAE/Nb8PHsuVG/1enQuMfwDDPFNX5NoX3vvT/qiE51dKFm
         KSFjjbLoBI7PR4sX7PK8DBUr5Ntf9ym0z54ggItEogJ0j/9X97tG2DETkNgLbeLgr5nj
         itpfNHy+h1qYlaGJ40ekNtbP9fZ4ICY/SD76zaPNoidcfNbkq1EwwybJed03cj6H1K0R
         AEtw==
X-Gm-Message-State: AOAM530gCVNsjySNU9uDne9kpAAAn7DlMy7ghuioLA7pfxR8AIDt1Qun
        meesYn7AIjaRfJp+ajIuwmyAcgHIft8T9bCIWVFiZZUepwc=
X-Google-Smtp-Source: ABdhPJxkGPbuNpMuxwNLGh9nmsjcv0X9pWcDSBKydaeqs7b9G1lKY/GVvajbJpS93+i9BS1an56H3czyyp7Kmr8PSPY=
X-Received: by 2002:a05:6214:1c83:b0:443:6749:51f8 with SMTP id
 ib3-20020a0562141c8300b00443674951f8mr18046761qvb.74.1650527566106; Thu, 21
 Apr 2022 00:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220419131423.2367795-1-brauner@kernel.org> <20220420175221.2502964-1-brauner@kernel.org>
 <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox> <20220421070513.wcqz7kzmcm3u5uok@wittgenstein>
 <20220421071831.GA24199@lst.de>
In-Reply-To: <20220421071831.GA24199@lst.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Apr 2022 10:52:35 +0300
Message-ID: <CAOQ4uxhbBsrnPWPdT2MSUJu+vC8rT0Ykk+JAZRe+pBWcH=hLig@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 21, 2022 at 10:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Apr 21, 2022 at 09:05:13AM +0200, Christian Brauner wrote:
> > I'd like to avoid that. The testsuite tests a lot of core vfs
> > functionality - completely indepenent of idmapped mounts which is why I
> > should rename it - that isn't covered anwywhere else in xfstests.
> > It also contains various regressions tests for core vfs work.
> > Let's keep it in a single repo which will guarantee us that it will be
> > run as part of xfstests.
>
> Yeah, that unionmount testsuite is something no casual users will
> run as it requires way too much effort to be usable.

Please elaborate.

Quoting from README.overlay:

To enable running unionmount testsuite, clone the git repository from:
  https://github.com/amir73il/unionmount-testsuite.git
under the xfstests src directory, or set the environment variable
UNIONMOUNT_TESTSUITE to the local path where the repository was cloned.

Is that what you are referring to by "way too much effort to be usable"?

To be clear, I too am in favor of keeping unionmount testsuite in separate
repo and keeping idmapped-mounts inside xfstests.

Just puzzled about your comment.

Thanks,
Amir.
