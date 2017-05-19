Received: from mail-oi0-f68.google.com ([209.85.218.68]:34697 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdESIkh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 May 2017 04:40:37 -0400
Received: by mail-oi0-f68.google.com with SMTP id w10so11350662oif.1
        for <fstests@vger.kernel.org>; Fri, 19 May 2017 01:40:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170519073911.GA28321@zzz>
References: <20170517233233.61244-1-ebiggers3@gmail.com> <20170517233233.61244-2-ebiggers3@gmail.com>
 <20170518184433.qq2g43s4za6hrfjz@thunk.org> <CAOQ4uxiygvNT07ZWLss8nnNRe4VVNuhAF5WRLSpRP7vYffibyA@mail.gmail.com>
 <20170519073911.GA28321@zzz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 May 2017 11:40:35 +0300
Message-ID: <CAOQ4uxhmk1z_PKz+tLr+dwcTf9TMA-Wz0PP5vLvymp7xnNqgYA@mail.gmail.com>
Subject: Re: [PATCH 1/5] kernel-configs: switch to using defconfigs
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Fri, May 19, 2017 at 10:39 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> Hi Amir,
>
> On Fri, May 19, 2017 at 10:05:35AM +0300, Amir Goldstein wrote:
>> On Thu, May 18, 2017 at 9:44 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>> > On Wed, May 17, 2017 at 04:32:29PM -0700, Eric Biggers wrote:
>> >> From: Eric Biggers <ebiggers@google.com>
>> >>
>> >> Currently, the kernel configs for kvm-xfstests and gce-xfstests are
>> >> difficult to maintain because they are so long.  Fix this by changing
>> >> them to 'defconfig' format, so they only list the non-default settings.
>> >>
>> >> As documented, there is one additional step introduced when building a
>> >> kernel for the first time: you now must run 'make olddefconfig' after
>> >> copying a defconfig file to .config.  However I think this is an
>> >> acceptable tradeoff for having much more maintainable config files.
>> >> Running 'make olddefconfig' also means that people won't have to answer
>> >> random config questions if they're testing the latest kernel.
>> >>
>> >> This change was scripted by running 'make savedefconfig' for each config
>> >> within the appropriate source tree (stable/linux-X.X-y).
>> >>
>> >> Signed-off-by: Eric Biggers <ebiggers@google.com>
>> >
>> > Thanks, applied.  (This patch was 1.4MB, so it would have been
>> > rejected by vger.kernel.org.)
>> >
>>
>> Ted,
>>
>> Applied where? github is 2 weeks behind. kernel.org is 2 weeks behind.
>>
>> BTW, I am curious to know why the kernel-configs in this repository have
>> no obvious debug config options.
>>
>> Aren't you guys testing regularly with lockdep etc? does everyone carry
>> their own home brewed debug configs like I do [1]?
>>
>> What do you say about including -debug variants to the maintained
>> kernel-configs in this repo? or turn on the obvious debugging features
>> by default?
>>
>
> There are already a number of debugging options turned on in the 4.9 x86_64
> config, including lockdep, various other CONFIG_DEBUG_* options, and the crypto
> self-tests.  It definitely should still be improved, though.  I've been planning
> to go through it again and see if there are any other debug options that should
> be turned on, as well as unused features which should be disabled.  Also the
> older configs tend to be outdated and should be synced up with the latest

Right, I actually diffed my debug config with latest and missed the
fact that lockdep
was turned on in upstream sometime after I forked my config.

Interesting configs I found in my diff you may want to consider:
-CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
-CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_INFO_REDUCED=y
-CONFIG_HARDENED_USERCOPY=y
-CONFIG_DEBUG_ATOMIC_SLEEP=y

Cheers,
Amir.
