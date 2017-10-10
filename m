Received: from mail-qt0-f193.google.com ([209.85.216.193]:37898 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbdJJSOn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Oct 2017 14:14:43 -0400
Received: by mail-qt0-f193.google.com with SMTP id k31so7498611qta.5
        for <fstests@vger.kernel.org>; Tue, 10 Oct 2017 11:14:42 -0700 (PDT)
Date: Tue, 10 Oct 2017 14:14:40 -0400
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 1/2] fstests: add fio perf results support
Message-ID: <20171010181439.c5ufjotgo4f3zbkf@destiny>
References: <1507656085-17101-1-git-send-email-josef@toxicpanda.com>
 <1507656085-17101-2-git-send-email-josef@toxicpanda.com>
 <20171010175312.GA23353@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010175312.GA23353@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, fstests@vger.kernel.org, david@fromorbit.com, tytso@mit.edu, Josef Bacik <jbacik@fb.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 10, 2017 at 10:53:12AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 10, 2017 at 01:21:24PM -0400, Josef Bacik wrote:
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
> > ---
> >  .gitignore                         |   1 +
> >  common/config                      |   2 +
> >  common/rc                          |  32 +++++++++++
> >  src/perf/FioCompare.py             | 106 +++++++++++++++++++++++++++++++++++++
> >  src/perf/FioResultDecoder.py       |  58 ++++++++++++++++++++
> >  src/perf/ResultData.py             |  43 +++++++++++++++
> >  src/perf/fio-insert-and-compare.py |  32 +++++++++++
> >  src/perf/fio-results.sql           |  93 ++++++++++++++++++++++++++++++++
> >  src/perf/generate-schema.py        |  49 +++++++++++++++++
> >  9 files changed, 416 insertions(+)
> >  create mode 100644 src/perf/FioCompare.py
> >  create mode 100644 src/perf/FioResultDecoder.py
> >  create mode 100644 src/perf/ResultData.py
> >  create mode 100644 src/perf/fio-insert-and-compare.py
> >  create mode 100644 src/perf/fio-results.sql
> >  create mode 100644 src/perf/generate-schema.py
> > 
> > diff --git a/.gitignore b/.gitignore
> > index ae7ef87ab384..986a6f7ff0ad 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -156,6 +156,7 @@
> >  /src/aio-dio-regress/aiocp
> >  /src/aio-dio-regress/aiodio_sparse2
> >  /src/log-writes/replay-log
> > +/src/perf/*.pyc
> >  
> >  # dmapi/ binaries
> >  /dmapi/src/common/cmd/read_invis
> > diff --git a/common/config b/common/config
> > index 71798f0adb1e..d2b2e2cda688 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -195,6 +195,8 @@ export MAN_PROG="`set_prog_path man`"
> >  export NFS4_SETFACL_PROG="`set_prog_path nfs4_setfacl`"
> >  export NFS4_GETFACL_PROG="`set_prog_path nfs4_getfacl`"
> >  export UBIUPDATEVOL_PROG="`set_prog_path ubiupdatevol`"
> > +export PYTHON_PROG="`set_prog_path python`"
> 
> Given that /usr/bin/python will some day point to python 3 instead of
> python 2 (and all of the grief that will ensue when someone has to run
> fstests on, say, 2019 and 2021-era Linux distros at the same time when
> they finally start pointing /usr/bin/python to 3.x), I think we should
> avoid relying on /usr/bin/python to run our fstests scripts.
> 
> ISTR in the previous thread that python 2.7 was a requirement for the
> scripts below, so find the python2 binary instead.  It might even be a
> good idea to have a _require_python_version helper to check that the
> interpreter exists and that it's of a specific vintage.
> 

My scripts run fine on both 2 and 3.  I'm worried about other distro's, does
everybody do the python2/python3 thing?  If so then I'll just default to
python2, I just have no idea if that's a thing beyond Fedora/RHEL.

> > +export SQLITE3_PROG="`set_prog_path sqlite3`"
> >  
> >  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
> >  # newer systems have udevadm command but older systems like RHEL5 don't.
> > diff --git a/common/rc b/common/rc
> > index 53bbb1187f81..2660ad51ed26 100644
> > --- a/common/rc
> > +++ b/common/rc
> 
> Should we put this in common/perf in case we start adding more
> performance testing helper functions?  common/rc is already a mess.
> 

Yeah I can do that.

> > @@ -2997,6 +2997,38 @@ _require_fio()
> >  	[ $? -eq 0 ] || _notrun "$FIO_PROG too old, see $seqres.full"
> >  }
> >  
> > +_fio_results_init()
> 
> I'd put the requirements checking into a separate
> _require_fio_results_dependencies() helper because any funcion call
> starting with '_require' signals (to me anyway) that we're checking for
> required software and will _notrun if we don't find it.
> 
> Test initialization functions, by contrast, only get run once the
> _require* calls are finished and we therefore know that we have all the
> external pieces we need to run the test.  If init doesn't succeed, the
> test can _fail.

Agreed, I'll fix it.  Thanks,

Josef
