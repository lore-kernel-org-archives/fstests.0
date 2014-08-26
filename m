Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18886 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbaHZRcR (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 26 Aug 2014 13:32:17 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch, v3] add an aio test which closes the fd before destroying the ioctx
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
	<20140820225701.GG26465@dastard>
	<x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
	<20140821165750.GA7116@lenny.home.zabbo.net>
	<20140825165043.GF20070@kvack.org>
	<x49oav76xu0.fsf@segfault.boston.devel.redhat.com>
	<20140826172740.GA18337@lenny.home.zabbo.net>
Date: Tue, 26 Aug 2014 13:32:11 -0400
In-Reply-To: <20140826172740.GA18337@lenny.home.zabbo.net> (Zach Brown's
	message of "Tue, 26 Aug 2014 10:27:40 -0700")
Message-ID: <x49a96r6tt0.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Zach Brown <zab@zabbo.net>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Zach Brown <zab@zabbo.net> writes:

> On Tue, Aug 26, 2014 at 12:05:11PM -0400, Jeff Moyer wrote:
>> Benjamin LaHaise <bcrl@kvack.org> writes:
>> 
>> > Does someone already have a simple test case we can add to the libaio test 
>> > suite to verify this behaviour?
>> 
>> I can't reproduce this problem using a loop device, which is what the
>> libaio test suite uses.  Even when using real hardware, you have to have
>> disks that are slow enough in order for this to trigger reliably (or
>> at all).
>
> I wonder if you could use something like dm suspend to abuse indefinite
> latencies.

Or perhaps dm-delay.

>> I could write a more targeted test within xfstests, but I don't think
>> that's strictly necessary (it would just make it more clear what the
>> expectations are, and maybe bump the hit rate percentage up).
>
> I think it'd be worth it (he says, not commiting *his* time).  It would
> have been nice if a targeted test helped Dave raise the alarm
> immediately rather than gnaw away at his brain with inconsistent mostly
> unrelated failures for months.

Sure.

-Jeff
