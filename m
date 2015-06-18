Received: from mail-qc0-f169.google.com ([209.85.216.169]:36320 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509AbbFRQZg (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 18 Jun 2015 12:25:36 -0400
Date: Thu, 18 Jun 2015 12:25:59 -0400
From: Eric Whitney <enwlinux@gmail.com>
Subject: Re: Test generic/299 stalling forever
Message-ID: <20150618162559.GA1780@localhost.localdomain>
References: <20150618155337.GA10439@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150618155337.GA10439@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

* Theodore Ts'o <tytso@mit.edu>:
> I've been trying to figure out why generic/299 has occasionally been
> stalling forever.  After taking a closer look, it appears the problem
> is that the fio process is stalling in userspace.  Looking at the ps
> listing, the fio process hasn't run in over six hours, and using
> attaching strace to the fio process, it's stalled in a FUTUEX_WAIT.
> 
> Has anyone else seen this?  I'm using fio 2.2.6, and I have a feeling
> that I started seeing this when I started using a newer version of
> fio.  So I'm going to try roll back to an older version of fio and see
> if that causes the problem to go away.
> 

I've not seen that, but have only been running 4.1-rc* kernels recently.  I
can say that I ran 1000 trials of generic/299 on nojournal using a vanilla
4.1-rc6 kernel on a Pandaboard successfully with fio 2.2.6.  No failures, and
completed in ~61 hours for an average test duration of ~3.7 minutes, which
agrees well with what I see when sampling the logged output for individual
test times.

Eric

