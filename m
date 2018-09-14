Received: from mx1.redhat.com ([209.132.183.28]:58608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbeINGVk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 14 Sep 2018 02:21:40 -0400
Date: Fri, 14 Sep 2018 09:10:30 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] shared/010: avoid dedupe testing blocked on large fs
Message-ID: <20180914011030.GI8382@dhcp-12-152.nay.redhat.com>
References: <20180912101547.28835-1-zlang@redhat.com>
 <2fc0ab97-1fb1-7502-6eff-fbfbbade05d5@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc0ab97-1fb1-7502-6eff-fbfbbade05d5@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 13, 2018 at 11:28:26AM -0500, Eric Sandeen wrote:
> On 9/12/18 5:15 AM, Zorro Lang wrote:
> > When test on large fs (--large-fs), xfstests preallocates a large
> > file in SCRATCH_MNT/ at first. Duperemove will take too long time
> > to deal with that large file (many days on 500T XFS). So move
> > working directory to a sub-dir underlying $SCRATCH_MNT/.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> 
> Looks fine to me - 
> 
> Reviewed-by: Eric Sandeen <sandeen@redhat.com>
> 
> But - I'm not sure what you mean about "testdir?"

Read shared/010 before merge this patch, you'll find a "$testdir" on
this line:
  find $testdir -type f -exec md5sum {} \; > ${tmp}.md5sum

But that "$testdir" never be assigned, it's a mistake I left :)

Thanks,
Zorro

> 
> > ---
> > 
> > Hi,
> > 
> > Besides fix this issue, this patch fix another issue passingly. I left
> > a bad variable named "testdir" in this case. This patch can fix it.
> > 
> > If maintainer feels I should fix it in another patch, please tell me:-P
> > 
> > Thanks,
> > Zorro
> > 
> >  tests/shared/010 | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/shared/010 b/tests/shared/010
> > index 1817081b..04f55890 100755
> > --- a/tests/shared/010
> > +++ b/tests/shared/010
> > @@ -65,15 +65,17 @@ function end_test()
> >  sleep_time=$((50 * TIME_FACTOR))
> >  
> >  # Start fsstress
> > +testdir="$SCRATCH_MNT/dir"
> > +mkdir $testdir
> >  fsstress_opts="-r -n 1000 -p $((5 * LOAD_FACTOR))"
> > -$FSSTRESS_PROG $fsstress_opts -d $SCRATCH_MNT -l 0 >> $seqres.full 2>&1 &
> > +$FSSTRESS_PROG $fsstress_opts -d $testdir -l 0 >> $seqres.full 2>&1 &
> >  dedup_pids=""
> >  dupe_run=$TEST_DIR/${seq}-running
> >  # Start several dedupe processes on same directory
> >  touch $dupe_run
> >  for ((i = 0; i < $((2 * LOAD_FACTOR)); i++)); do
> >  	while [ -e $dupe_run ]; do
> > -		$DUPEREMOVE_PROG -dr --dedupe-options=same $SCRATCH_MNT/ \
> > +		$DUPEREMOVE_PROG -dr --dedupe-options=same $testdir \
> >  			>>$seqres.full 2>&1
> >  	done &
> >  	dedup_pids="$! $dedup_pids"
> > 
