Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDDDC63793
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Jul 2021 10:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F946120C
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Jul 2021 10:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhGVKSj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Jul 2021 06:18:39 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:53158 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbhGVKSj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Jul 2021 06:18:39 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id A7DBE6AD2F;
        Thu, 22 Jul 2021 20:59:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m6WPz-009SON-Un; Thu, 22 Jul 2021 20:59:07 +1000
Date:   Thu, 22 Jul 2021 20:59:07 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] [RFC] fstests: generic test hook infrastructure
Message-ID: <20210722105907.GD2112234@dread.disaster.area>
References: <20210722064725.3077558-1-david@fromorbit.com>
 <a8d305d5-010f-d8bc-bab0-e21b6463bcb9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8d305d5-010f-d8bc-bab0-e21b6463bcb9@gmx.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=IkcTkHD0fZMA:10 a=e_q4qTt1xDgA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8 a=oPMJ_XkHo8ObPimikiMA:9
        a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 22, 2021 at 05:23:20PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/22 下午2:47, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > For discussion. This embodies the infrastructure I was suggesting
> > here:
> > 
> > https://lore.kernel.org/fstests/342381aa-9e1f-f81c-f0e4-a72f70f8ac48@suse.com/T/#m8ff385bb5b8eab9ea5ed5fb45f253fda8b087fcf
> > 
> > Essentially:
> > 
> > hooks/start/generic-001.0
> > 
> > will be run when generic/001 is set up but before the test starts.
> > 
> > hooks/end/generic-001.0
> > 
> > will be run when generic/001 _cleanup() is called but before any
> > cleanup is done. i.e. we know if the test had a hard failure, but
> > not whether there was a goldem image mismatch. Global hooks are
> > named "global.N". The integer suffix is to allow multiple hooks to
> > be stacked and ordered so we can combins simple hook scripts into
> > much more complex monitoring setups without having to write a custom
> > hook for every use case. e.g. a common trace-cmd hook to turn on
> > trace_printk recording...
> > 
> > In general, hooks/ is intended to contain symlinks to generic hooks
> > scripts held elsewhere in the git tree.
> 
> Whether the hooks should be maintained by fstests is still debatable in
> my opinion.

All the frequent use cases should be supported by the infrastructure
so we don't require hundreds of people to rewrite the same basic
stuff over and over again.

> > That way we can have common
> > hooks for doing things like turning tracing on and off, but only
> > execute them for the tests we want to trace. The current curated
> > hook scripts can be found in tests/Hooks. It is named with "H"
> > because then the Makefile automatically skips it when generating
> > group lists.
> > 
> > The hook scripts run in the full test environment, so can _not_run
> > and _fail tests.
> 
> This is what I actually want to avoid.
> 
> In fact, exposing the whole test environment itself is asking the hook
> creators to be creative to exploit the fact (like overriding some
> existing macros/environment/etc), and greatly increase the maintenance
> burden.

That's the whole point of curating a library of commonly/frequently
needed hooks. This is no different to having modifications to a test
for debugging in a private patch vs sending it upstream so that you
don't have to keep forward porting it every time something gets
changed.

> As now hooks are at the same level of test cases, thus one just renaming
> _not_run() would affect all the private hooks in the wild.

How is that different to having a bunch of private test
modifications for debugging? We all have them, we all do them, and
they all bit rot over time and we fix them as we need them. If they
are truly useful, then we push them upstream so everyone has access
to that functionality.

AFAICT, your requirements seem to be based around allowing private
libraries of limited functionality to be maintained without the risk
of ever having their API broken.

What I think you haven't understood is that the functionality you
describe is a subset of what I've proposed. Damien kinda pointed
this out, but you missed it then, too. IOWs, if you want a
restricted hook interface that provides these requirements:

> Thus I prefer to completely limit the access to the full environment.
> A hook should only receive the minimal amount of info:
> 
> - Test number
> - Hook specific temporary path
> - Return value (for end hook)
> 
> And to allow a hook to terminate/end the test, we can require a super
> simple check for the return value:
> 
> - 0 to continue
> - Everything else to skip or terminate the test.
>   Depends on the setting (the only extra setting for hook)
>   With proper prompt of course.
> 
>   I originally considered the idea from Ted is the correct way to go,
>   but I don't believe even developer would read the doc to know how to
>   skip the test, then just go the super simple.
> 
> The less info a hook gets, the less maintenance burden.

Then you can simply write a pair of global hooks (one start, one
end) for the infrastructure that I have proposed that runs your
private restricted hooks scripts held in hooks/ the way you want.

Then you can push those restricted environment hooks scripts up into
the curated upstream tests/Hooks library, and now *everyone* has
access to the functionality you need. And it will be maintained by
fstests developers, too.

Hence we end up with both sets of functionailty supported through
the one mechanism, and you can then go about building your own
private restricted hook library without caring about what other
developers do with the more functional, tightly integrated hook
interface...

> >   create mode 100644 tests/Hooks/trace-cmd-failure-stop
> >   create mode 100644 tests/Hooks/trace-cmd-start-xfs
> >   create mode 100644 tests/Hooks/trace-cmd-start-xfs-log
> >   create mode 100644 tests/Hooks/trace-cmd-stop
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 2d72b064..c06cd6d8 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -10,6 +10,7 @@ tags
> > 
> >   /local.config
> >   /results
> > +/hooks
> > 
> >   # autogenerated group files
> >   /tests/*/group.list
> > @@ -45,6 +46,7 @@ tags
> >   # custom config files
> >   /configs/*.config
> > 
> > +
> ?

Oh, I moved stuff about in the file. I didn't clean the patch up -
didn't even look at the diff. Too busy actually using the code to
uncover more bugs....

> >   # ltp/ binaries
> >   /ltp/aio-stress
> >   /ltp/doio
> > diff --git a/common/preamble b/common/preamble
> > index 66b0ed05..7ef7d5b1 100644
> > --- a/common/preamble
> > +++ b/common/preamble
> > @@ -1,13 +1,114 @@
> >   #!/bin/bash
> > -# SPDX-License-Identifier: GPL-2.0
> > +# SPDX-License-Identifier: GPL-1.0
> 
> Why re-license?

Not intentional, not sure how that happened.

> >   # Copyright (c) 2021 Oracle.  All Rights Reserved.
> > +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> > 
> >   # Boilerplate fstests functionality
> > 
> > +# Hooks are scripts that are run at defined events within a test execution.
> > +# The run in the test environment, so can interact with tests in interesting
> > +# ways.
> > +#
> > +# Start hooks are run once the test environment has been set up but before
> > +# the test execution starts.
> > +#
> > +# End hooks run from the cleanup function of the test but before any cleanup
> > +# action has been performed. Hence they have access to the entire state of the
> > +# test at exit and know whether the test has failed or not. Cleanup actions will
> > +# be run after the hook has completed.
> > +#
> > +# Hooks are implemented via a hook_execute() function in the hook script. A hook
> > +# without such a function will do nothing.
> 
> Again, a specific thing script writers need to learn.

No big deal and most certainly not a negative - we have to learn new
stuff every day to do our jobs effectively. WE also need to
acknowledge that fstests requires developers doing debugging to
learn an awful lot more than "hooks run via hook_execute()" before
they can effectively debug problems that fstests exposes. So I don't
think "API is a single function call" is an issue at all...

> I don't think just executing a bash script could be that different.
> And it will need extra wrapping if one guy is running binary hooks.
> 
> Adding new restriction is just asking for more trouble in my opinion.

Did you look at the way the hooks are run? They don't get executed
and aren't stand-alone bash scripts. The hook infrastructure sources
them, then runs the hook directly inside the test environment via
the hook_execute() function. IOWs, the hook scripts need a defined
entry point to run them -  a hook, if you will....

> > +#
> > +# The vector that executes the hook can be accessed from the hook script via the
> > +# $_hook varible. Tests never see this variable, or know that hooks exist.
> > +#
> > +# Output from the hook script ends up in the test output file, so hooks need to
> > +# be silent on stdout otherwise they will cause test failures. Information that
> > +# hooks want to output should be directed to $seqres.full or there own
> > +# $seqres.<type> output files. e.g. tracing output could be directed to
> > +# $seqres.trace, raw trace files to $seqres.trace.dat, etc.
> > +#
> > +# Hooks can use _notrun and _fail to prevent a test from running or triggering a
> > +# hard failure.
> > +#
> 
> Should be in README.hooks, don't expect anyone to read things deep here,
> especially linking preamble with hook is not that obvious.

Yup, I send this RFC knowing that I'd have to do this, but it was
far mroe important to use it for debugging a high priority problem
than polishing the patch....

This'll all get cleaned up. What I'm more interested in is hearing
about other use cases that might not be covered by the
infrastructure I've proposed. As I explained above, I've got yours
covered and I've got my current requirements covered. But I don't
know about anyone else - I suspect I've got Ted's requirements
covered as well, but I'd like to hear from him whether there's any
tweaks that would make it more useful for his purposes, too.

BTW, hooks/ is extensible by event type. We have start and end
events in this patch, but we could add hooks for any type of common
operation that fstests runs (e.g. mkfs) just by adding a new hook
callout and hooks/<event_type> directory to store the hooks to run...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
