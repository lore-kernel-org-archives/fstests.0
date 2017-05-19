Received: from mail-oi0-f66.google.com ([209.85.218.66]:33613 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbdESHFg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 May 2017 03:05:36 -0400
Received: by mail-oi0-f66.google.com with SMTP id h4so11092258oib.0
        for <fstests@vger.kernel.org>; Fri, 19 May 2017 00:05:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170518184433.qq2g43s4za6hrfjz@thunk.org>
References: <20170517233233.61244-1-ebiggers3@gmail.com> <20170517233233.61244-2-ebiggers3@gmail.com>
 <20170518184433.qq2g43s4za6hrfjz@thunk.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 May 2017 10:05:35 +0300
Message-ID: <CAOQ4uxiygvNT07ZWLss8nnNRe4VVNuhAF5WRLSpRP7vYffibyA@mail.gmail.com>
Subject: Re: [PATCH 1/5] kernel-configs: switch to using defconfigs
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Biggers <ebiggers3@gmail.com>, fstests <fstests@vger.kernel.org>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, May 18, 2017 at 9:44 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Wed, May 17, 2017 at 04:32:29PM -0700, Eric Biggers wrote:
>> From: Eric Biggers <ebiggers@google.com>
>>
>> Currently, the kernel configs for kvm-xfstests and gce-xfstests are
>> difficult to maintain because they are so long.  Fix this by changing
>> them to 'defconfig' format, so they only list the non-default settings.
>>
>> As documented, there is one additional step introduced when building a
>> kernel for the first time: you now must run 'make olddefconfig' after
>> copying a defconfig file to .config.  However I think this is an
>> acceptable tradeoff for having much more maintainable config files.
>> Running 'make olddefconfig' also means that people won't have to answer
>> random config questions if they're testing the latest kernel.
>>
>> This change was scripted by running 'make savedefconfig' for each config
>> within the appropriate source tree (stable/linux-X.X-y).
>>
>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>
> Thanks, applied.  (This patch was 1.4MB, so it would have been
> rejected by vger.kernel.org.)
>

Ted,

Applied where? github is 2 weeks behind. kernel.org is 2 weeks behind.

BTW, I am curious to know why the kernel-configs in this repository have
no obvious debug config options.

Aren't you guys testing regularly with lockdep etc? does everyone carry
their own home brewed debug configs like I do [1]?

What do you say about including -debug variants to the maintained
kernel-configs in this repo? or turn on the obvious debugging features
by default?

Amir.

[1] https://github.com/amir73il/xfstests-bld/commit/af76cac689ea726cb8f5b222010b7818a689809b
