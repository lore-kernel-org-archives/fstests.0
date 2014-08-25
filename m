Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40141 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256AbaHYRzy (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 25 Aug 2014 13:55:54 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch, v3] add an aio test which closes the fd before destroying the ioctx
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
	<20140820225701.GG26465@dastard>
	<x49vbpmwwvc.fsf@segfault.boston.devel.redhat.com>
	<20140821165750.GA7116@lenny.home.zabbo.net>
	<20140825165043.GF20070@kvack.org>
Date: Mon, 25 Aug 2014 13:55:48 -0400
In-Reply-To: <20140825165043.GF20070@kvack.org> (Benjamin LaHaise's message of
	"Mon, 25 Aug 2014 12:50:43 -0400")
Message-ID: <x49k35w5u8r.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Zach Brown <zab@zabbo.net>, Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Benjamin LaHaise <bcrl@kvack.org> writes:

> Does someone already have a simple test case we can add to the libaio test 
> suite to verify this behaviour?

Well, we're running into this with xfstests, so we have a unit test that
will exit w/o waiting on iocbs.  Follow that up with a umount of the fs,
and it should be doable in the libaio test harness.  I'll cook something
up.

> I'm assuming that waiting for one ioctx at a time is sufficient and we
> don't need to parallelise cancellation at exit.

I don't know of any workload that would be adversely affected, for
whatever that's worth.

Cheers,
Jeff
