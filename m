Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF794C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 14:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiGUOqM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiGUOqL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 10:46:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D0181B29
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yuVS24EXppuyVXr0AZUQCrsIqeQLSKdUWBQgYciQpCg=; b=IszqUt9/Jw4wDnpzl60IB5qkAO
        wIl0Xl2ecBaAyQbJ9NPSTBT2div23MvOUOmb6wWQhLO54JUKkrBB4Vk6kvqy4ioLtuMtLVnsIjiaE
        FfVFYl6DYYHJ4F6RZ6ufFYXtigmn9N/tLWvi6iNvgRAa3eVPeSqAai+Mso3bxExWde0ehL3ER87k2
        3LGr8Jb7aZKbnxaK2NzFbzUDEkmef9FKFFL9z2CfujazF7wfh6bRCs7hOYoF4qngAIrS6B7DOtmiO
        EsrJhHK7R5yJBXmXgWKCpB8+RcMIJftlJl9xFN/wDOzToufQzGrokPJZGQCUnX/yEq+Z6QkxckkkH
        /0gMpQhQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEXRI-008F2U-Ry; Thu, 21 Jul 2022 14:46:08 +0000
Date:   Thu, 21 Jul 2022 07:46:08 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     chandanrmail@gmail.com, Josef Bacik <josef@toxicpanda.com>,
        Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: Collaborating updates of kdevops xfstests repo
Message-ID: <YtlmsH6vohI2/ttV@bombadil.infradead.org>
References: <YpjVcHuxhEQwPusN@bombadil.infradead.org>
 <CAOQ4uxi0eY3ybXbL6TEZv27HUoBaSTcthjC7aHRCTzACfyq52w@mail.gmail.com>
 <CAB=NE6XAL1+OXV0X5zBZCMWsqsy-xz9E6rkwPkGOHRXyG4sohg@mail.gmail.com>
 <CAOQ4uxjbJWt06bx_iE2mh=JemuM+fAAGU2WGYV7vOWQzvY4wMQ@mail.gmail.com>
 <CAOQ4uxjHp5iz4kP1qRbQtXSu3frVUhvxr23Gc0jzW9nY+_ep3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjHp5iz4kP1qRbQtXSu3frVUhvxr23Gc0jzW9nY+_ep3A@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 11:15:04AM +0200, Amir Goldstein wrote:
> Hi Luis,
> 
> I have been on vacation and partly still on vacation.
> Quick question.
> 
> Soon I will want to update the shared xfstetsts repo - it has not been
> updated since v2022.07.10

That's slightly over a month.

> I am still waiting on the SGID tests [1] to land, which may take a few more
> weeks, because I have a bunch of 5.10 backports related to SGID fixes
> that I would like to validate with those tests.

Neat, good to know.

> My question is, at the moment, who are the active kdevops users that you
> know of that will be affected by an update like that?

SUSE has its own git subtree to manage their own delta and set of
changes, so typically updates don't affect that tree. But just in
case you can Cc Anthony.

I know Pankaj also uses it for his own ZNS development. And then there
are those that I am not sure of, but it's all good, I think its fair we
just set users to expect us to update maybe once or twice a month. Typically
I've found there may be small snafu bugs in one release and have to
update soon to fix those issues, or I just fix it myself and carry this
on our own tree until those fixes land upstream. This is why we have our
tree for it, so to give us the flexibility to ensure we can reach
stability.

If you look fstests has no release tags. Long term I think it would be
wonderful if we strive for that, perhaps in stride / linking with the
latest kernel release rc tag at that time, but what would a release
tag mean? Obviously some sort of stability, but how can we vet for this?

[0] https://github.com/linux-kdevops/fstests

> Updating the kdevops clone of xfstests repo is going to have an immediate
> side effect of "destabilizing" all the established baselines.

Sure.

> I will announce it on fstests lists, but wanted to give a heads up
> and collaborate the update with the active kdevops users first.

You can also just use the discord server.

  Luis

> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/fstests/bc3f8e56-d5fa-bee2-741f-d2950ca6e304@fujitsu.com/
