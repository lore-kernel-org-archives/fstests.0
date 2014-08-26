Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10651 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbaHZQFW (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 26 Aug 2014 12:05:22 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch, v3] add an aio test which closes the fd before destroying the ioctx
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
	<20140820225701.GG26465@dastard>
	<x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
	<20140821165750.GA7116@lenny.home.zabbo.net>
	<20140825165043.GF20070@kvack.org>
Date: Tue, 26 Aug 2014 12:05:11 -0400
In-Reply-To: <20140825165043.GF20070@kvack.org> (Benjamin LaHaise's message of
	"Mon, 25 Aug 2014 12:50:43 -0400")
Message-ID: <x49oav76xu0.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Zach Brown <zab@zabbo.net>, Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Benjamin LaHaise <bcrl@kvack.org> writes:

> Does someone already have a simple test case we can add to the libaio test 
> suite to verify this behaviour?

I can't reproduce this problem using a loop device, which is what the
libaio test suite uses.  Even when using real hardware, you have to have
disks that are slow enough in order for this to trigger reliably (or
at all).  Given those two points, I think it might make sense to
continue to use xfstests to find this problem for us, since it already
has the infrastructure in place to test real devices and since it
already triggers the problem.  I could write a more targeted test within
xfstests, but I don't think that's strictly necessary (it would just
make it more clear what the expectations are, and maybe bump the hit
rate percentage up).

Cheers,
Jeff
