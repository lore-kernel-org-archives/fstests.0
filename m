Received: from mail-qt0-f175.google.com ([209.85.216.175]:53131 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933811AbdKPPo1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Nov 2017 10:44:27 -0500
Received: by mail-qt0-f175.google.com with SMTP id 31so43696684qtz.9
        for <fstests@vger.kernel.org>; Thu, 16 Nov 2017 07:44:27 -0800 (PST)
Date: Thu, 16 Nov 2017 10:44:25 -0500
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 1/2][v4] fstests: add fio perf results support
Message-ID: <20171116154424.zrzjwa5gsa2esnn4@destiny>
References: <1510091613-17357-1-git-send-email-josef@toxicpanda.com>
 <20171116052204.GX17339@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171116052204.GX17339@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, david@fromorbit.com, tytso@mit.edu, darrick.wong@oracle.com, kernel-team@fb.com, fstests@vger.kernel.org, Josef Bacik <jbacik@fb.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 16, 2017 at 01:22:04PM +0800, Eryu Guan wrote:
> On Tue, Nov 07, 2017 at 04:53:32PM -0500, Josef Bacik wrote:
> > From: Josef Bacik <jbacik@fb.com>
> > 
> > This patch does the nuts and bolts of grabbing fio results and storing
> > them in a database in order to check against for future runs.  This
> > works by storing the results in resuts/fio-results.db as a sqlite
> > database.  The src/perf directory has all the supporting python code for
> > parsing the fio json results, storing it in the database, and loading
> > previous results from the database to compare with the current results.
> > 
> > This also adds a PERF_CONFIGNAME option that must be set for this to
> > work.  Since we all have various ways we run fstests it doesn't make
> > sense to compare different configurations with each other (unless
> > specifically desired).  The PERF_CONFIGNAME will allow us to separate
> > out results for different test run configurations to make sure we're
> > comparing results correctly.
> > 
> > Currently we only check against the last perf result.  In the future I
> > will flesh this out to compare against the average of N number of runs
> > to be a little more complete, and hopefully that will allow us to also
> > watch latencies as well.
> > 
> > Signed-off-by: Josef Bacik <jbacik@fb.com>
> 
> This v4 patches look fine to me overall, but it's really helpful if
> other filesystem developers could comment too, especially filesystem
> maintainers, as they're the key users of this fsperf infrastructure and
> tests.
> 
> I have just one question here, is there any recommended way or setup to
> run the perf tests? If there is, maybe we can document that too. Because
> I found that I need to drop caches and let the system calm down first,
> otherwise perf/001 fails randomly for me when run in sequence (I changed
> the write size to 2G for testing, as I don't have a 64G scratch device
> by hand). e.g.
> 
>     +    write_iops regressed: old 26175.137294 new 22161.129428 -15.3351931679%
>     +    write_bw regressed: old 104700 new 88644 -15.335243553%
>     +    elapsed regressed: old 21 new 24 14.2857142857%
> 
> or
> 
>     +    sys_cpu regressed: old 45.317789 new 55.639323 22.7758993273%
> 
> Or is this something we can do in the test?
> 

I think this is why it's important to have larger IO amounts, because otherwise
you are just going into RAM and that's going to affect the run to run numbers.
It's weird that dropping caches helps tho, presumably there's nothing else
happening on the box, and we umount after every run so cache should be
essentially empty between runs.  Thanks,

josef
