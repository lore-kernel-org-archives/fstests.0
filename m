Received: from mail-qt0-f176.google.com ([209.85.216.176]:56076 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753871AbdJRNcg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Oct 2017 09:32:36 -0400
Received: by mail-qt0-f176.google.com with SMTP id v41so10160835qtv.12
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2017 06:32:36 -0700 (PDT)
Date: Wed, 18 Oct 2017 09:32:33 -0400
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 2/2][v2] perf/001: a random write buffered fio perf test
Message-ID: <20171018133232.rqsg7p3bmk2sxnxm@destiny>
References: <1507665511-23515-1-git-send-email-josef@toxicpanda.com>
 <1507665511-23515-2-git-send-email-josef@toxicpanda.com>
 <20171018072625.GI10593@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018072625.GI10593@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org, tytso@mit.edu, david@fromorbit.com, darrick.wong@oracle.com, Josef Bacik <jbacik@fb.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 18, 2017 at 03:26:25PM +0800, Eryu Guan wrote:
> Hi Josef,
> 
> On Tue, Oct 10, 2017 at 03:58:31PM -0400, Josef Bacik wrote:
> > From: Josef Bacik <jbacik@fb.com>
> > 
> > This uses the new fio results perf helpers to run a rand write buffered
> > workload on the scratch device.
> > 
> > Signed-off-by: Josef Bacik <jbacik@fb.com>
> > ---
> > v1->v2:
> > - updated to use the new _require_fio_results helper and moved the
> >   _fio_results_init call to after teh _require_fio check
> 
> I tried this v2 a bit, but met some problems, I haven't looked into the
> code closely though, just wanted to get a first impression of this perf
> test frame work.
> 
> - missing perf/group file, so test won't be run by check

Sigh shit, I knew that was going to happen.  Forgot to add it to the commit,
I'll add it in there.

> - this test writes 16G files to SCRATCH_DEV by default, and my device
>   has only 15G, so fio failed with ENOSPC, I think we need a require
>   rule on the test device

Oops yup I'll fix that.

> - after working around the group file and device size issue, test still
>   failed like
> 
> perf/001.full:
> ....
> # /usr/local/bin/fio --output-format=json --output=/tmp/30750.json /tmp/30750.fio
> # /usr/bin/python2 /root/xfstests/src/perf/fio-insert-and-compare.py -c default -d /root/xfstests/results//fio-results.db -n 001 /tmp/30750.json
> Traceback (most recent call last):
>   File "/root/xfstests/src/perf/fio-insert-and-compare.py", line 28, in <module>
>     result_data.insert_result(data)
>   File "/root/xfstests/src/perf/ResultData.py", line 43, in insert_result
>     self._insert_obj('fio_jobs', job)
>   File "/root/xfstests/src/perf/ResultData.py", line 35, in _insert_obj
>     cur.execute(cmd, tuple(values))
> sqlite3.IntegrityError: fio_jobs.trim_lat_ns_mean may not be NULL
> failed: '/usr/bin/python2 /root/xfstests/src/perf/fio-insert-and-compare.py -c default -d /root/xfstests/results//fio-results.db -n 001 /tmp/30750.json'
> 
> Am I missing something? BTW, I was using fio-2.6-2.el7.x86_64.

Nope again I forgot to commit local changes, sorry about that.  I'll fix this up
and try again.  Thanks,

Josef
