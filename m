Received: from mail-pf0-f196.google.com ([209.85.192.196]:36251 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753404AbdEWCyl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 May 2017 22:54:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so24085306pfb.3
        for <fstests@vger.kernel.org>; Mon, 22 May 2017 19:54:41 -0700 (PDT)
Date: Mon, 22 May 2017 19:54:37 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] kvm-xfstests, gce-xfstests: improve recommended kernel
 config
Message-ID: <20170523025437.GA606@zzz>
References: <20170522172420.136541-1-ebiggers3@gmail.com>
 <20170523021938.biqavccr6bdyy5sc@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170523021938.biqavccr6bdyy5sc@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Hi Ted,

On Mon, May 22, 2017 at 10:19:38PM -0400, Theodore Ts'o wrote:
> On Mon, May 22, 2017 at 10:24:20AM -0700, Eric Biggers wrote:
> > -CONFIG_LOCK_STAT=y
> > -CONFIG_DEBUG_LOCKDEP=y
> 
> Lockdep has *definitely* found bugs for us, and so I don't think we
> want to turn it off.  lockstat is a interesting case.  It definitely
> can cause performance degredations, but it also can very find
> performance problems.
> 
> I can definitely see us potentially looking for locking hotspots by
> using a DAX configuration (or a /dev/ram configuration) using a
> n1-highcpu-64 GCE VM.  (Indeed, since Eric Whitney retired from HP,
> we've lost our only "big iron" system for doing scalability testing.)
> 
> The test appliance does currently export /proc/lock_stat via the www
> interface, although we're currently not saving it in the results
> tar.gz file.  (That's an oversight.)
> 
> So I have a slight preferene for leaving LOCK_STAT enabled, even if
> we're not using most of the time.  We're certainly not doing
> performance benchmarks using this config, at any rate!
> 

DEBUG_LOCKDEP is for debugging lockdep itself, not for turning on lockdep
(that's CONFIG_PROVE_LOCKING).  So I don't think it's needed.

I'm fine with leaving on LOCK_STAT; I didn't know there was interest in it.

Eric
