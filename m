Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27878 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbaFXTJB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 24 Jun 2014 15:09:01 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5OJ91CS002311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Tue, 24 Jun 2014 15:09:01 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch, v2] add an aio test which closes the fd before destroying the ioctx
References: <x49oaxjw8li.fsf@segfault.boston.devel.redhat.com>
	<20140624132738.GA45839@bfoster.bfoster>
Date: Tue, 24 Jun 2014 15:09:00 -0400
In-Reply-To: <20140624132738.GA45839@bfoster.bfoster> (Brian Foster's message
	of "Tue, 24 Jun 2014 09:27:39 -0400")
Message-ID: <x49lhsm86r7.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: xfstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Brian Foster <bfoster@redhat.com> writes:

> I missed the first pass of this, but the changelog (below) suggests the
> workaround demonstration was dropped so we might want to drop this part
> of the comment as well.

sure.

>> +done:
>> +		if ((fd >= 0) && (wait_for_events < 2)) {
>> +			close(fd);
>> +			fd = -1;
>> +		}
>
> This looks like it should change (wait_for_events >= 2 means an fd
> leak). I suspect the close() should be independent of wait_for_events.
> FWIW, setting fd = -1 seems extraneous as well.

Leftovers from the original code, good catch.

>> +	while (delta.tv_sec < 300) {
>> +		sleep(1);
>> +		gettimeofday(&now, NULL);
>> +		timersub(&now, &start, &delta);
>> +		dprintf("%lu loops completed in %ld seconds\n",
>> +			total_loop_count, delta.tv_sec);
>> +	}
>
> I'm not familiar with the background of this reproducer, but is 5
> minutes per iteration necessary? This test currently runs for a bit over
> 10 minutes. Would 60s or so per iteration provide the same level of
> coverage?

I re-tested, and yes, 1 minute should be fine.  I'll change that.

Thanks!
Jeff
