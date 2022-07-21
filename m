Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA24EC43334
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 16:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiGUQ0Z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGUQ0Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 12:26:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1698877F
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RgDu19LYCskNKDwWQo25NoaQLWhCBKjmO1xsHY/AUhE=; b=m6J1Ut1bR2JhUs+v/D4ZUkpDpd
        6JJSXLeLy51iOnd5gLknkEtnp8EOptEi4P9oLYeDFL9yErefKJAFH1LCp39F300HJsru4ZtNGOHEk
        daA+fb3PS/DlP5bIABd7Vv8jdIyMgnUQu8DYGhXfCK4I5pZZKI4WiX1xDt8N8V8ehRgzPzNN453Hg
        FVNgg6RnBGy8FkmRstXBlxGeNUKracE6CkYRlmSfSBHP01dbTNdGvFgL3fsdtdNjbP20iDODTh7uj
        f8Mq9v9O4iCmpjN1tYjbGh8xHX6Cy9/9yu5NkmVuEoH2yMLzryXBdrlpPWL5b82GYhFctYSVjBMYv
        roBfz9+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEZ0F-009vlF-O7; Thu, 21 Jul 2022 16:26:19 +0000
Date:   Thu, 21 Jul 2022 09:26:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>, chandanrmail@gmail.com,
        Josef Bacik <josef@toxicpanda.com>,
        Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: Collaborating updates of kdevops xfstests repo
Message-ID: <Ytl+K1HJGrN8KV9G@bombadil.infradead.org>
References: <YpjVcHuxhEQwPusN@bombadil.infradead.org>
 <CAOQ4uxi0eY3ybXbL6TEZv27HUoBaSTcthjC7aHRCTzACfyq52w@mail.gmail.com>
 <CAB=NE6XAL1+OXV0X5zBZCMWsqsy-xz9E6rkwPkGOHRXyG4sohg@mail.gmail.com>
 <CAOQ4uxjbJWt06bx_iE2mh=JemuM+fAAGU2WGYV7vOWQzvY4wMQ@mail.gmail.com>
 <CAOQ4uxjHp5iz4kP1qRbQtXSu3frVUhvxr23Gc0jzW9nY+_ep3A@mail.gmail.com>
 <YtlmsH6vohI2/ttV@bombadil.infradead.org>
 <Ytlp5ECl41Bvj0b3@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytlp5ECl41Bvj0b3@mit.edu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 10:59:48AM -0400, Theodore Ts'o wrote:
> On Thu, Jul 21, 2022 at 07:46:08AM -0700, Luis Chamberlain wrote:
> > If you look fstests has no release tags. Long term I think it would be
> > wonderful if we strive for that...
> 
> Since May, Zorro has started providing release tags --- it's tagged
> when he pushes a batch to for-next, and so far there hasn't been any
> changes between when a batch of updates get promoted from for-next to
> the master branch.
> 
> % git tag -l | grep ^v2022
> v2022.05.01
> v2022.05.08
> v2022.05.15
> v2022.05.22
> v2022.05.29
> v2022.06.05
> v2022.06.12
> v2022.06.26
> v2022.07.03

Fantastico.

> So if you want stability, you can wait until after the tag has been
> promoted to the master branch.  I've using the for-next branch for
> xfstests-bld, since I'm also doing development work for xfstests, and
> before I release an prebuilt image for kvm-xfstests or gce-xfstests,
> I've done a full sanity check run on at least ext4, xfs, btrfs, and
> f2fs.  And aside from a relatively rare hiccups, I've found for-next
> to be plenty stable enough for me.

This still begs the question of what can we count on for a tag, or if
want more.

> Of course, it's a bit easier for me, since I've explicitly *not* been
> promising that a reliable set of baseline configs that can be used for
> drive-by testers.

Git subtrees uses of kdevops can keep their own deltas / own fstests git
trees, etc. It was designed with that in mind.

> OTOH, last I checked, kdevops hasn't published new
> baselines since 5.17, which IMHO is way too old for drive-by testers
> who need to test patches meant for upstream submission anyway...

This is because of building confidence in a baseline on kdevops is done
first by striving for 100 consecutive runs of fstest and/or blktests
without failure and we lacked one for more recent kernels for a while.
Building confidence takes a while, but I consider it technical debt.

With a baseline with high confidence, it easy to bump one kernel
release, as the effort typically is just verifying prior known failures
(the status quo goes on) and picking up new ones. There would be high
confidence that these new failures are also regressions.

  Luis
