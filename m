Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44380 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbaLPDbJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 22:31:09 -0500
Date: Tue, 16 Dec 2014 11:31:05 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] check: treat _check_{test,scratch}_fs failures as
 test failures
Message-ID: <20141216033105.GZ15495@dhcp-13-216.nay.redhat.com>
References: <1418663367-18755-1-git-send-email-eguan@redhat.com>
 <1418663367-18755-2-git-send-email-eguan@redhat.com>
 <20141215232739.GC2152@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141215232739.GC2152@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 16, 2014 at 10:27:39AM +1100, Dave Chinner wrote:
> On Tue, Dec 16, 2014 at 01:09:27AM +0800, Eryu Guan wrote:
[snip]
> >  check | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/check b/check
> > index 42a1ac2..4cf7070 100755
> > --- a/check
> > +++ b/check
> > @@ -611,6 +611,16 @@ for section in $HOST_OPTIONS_SECTIONS; do
> >  			    err=true
> >  			fi
> >  		    fi
> > +		    try="$try $seqnum"
> > +		    n_try=`expr $n_try + 1`
> > +		    if [ -f ${RESULT_DIR}/require_test ]; then
> > +			_check_test_fs || err=true
> > +			rm -f ${RESULT_DIR}/require_test
> > +		    fi
> > +		    if [ -f ${RESULT_DIR}/require_scratch ]; then
> > +			_check_scratch_fs || err=true
> > +			rm -f ${RESULT_DIR}/require_scratch
> > +		    fi
> >  		fi
> >  
> >  	    fi
> > @@ -623,15 +633,6 @@ for section in $HOST_OPTIONS_SECTIONS; do
> >  		n_bad=`expr $n_bad + 1`
> >  		quick=false
> >  	    fi
> > -	    if [ ! -f $seqres.notrun ]
> > -	    then
> > -		try="$try $seqnum"
> > -		n_try=`expr $n_try + 1`
> > -		test -f ${RESULT_DIR}/require_test && _check_test_fs
> > -		rm -f ${RESULT_DIR}/require_test
> > -		test -f ${RESULT_DIR}/require_scratch && _check_scratch_fs
> > -		rm -f ${RESULT_DIR}/require_scratch
> > -	    fi
> >  
> >  	    seq="after_$seqnum"
> 
> Looks fine as is, but in the interest of slowly cleaning up check,
> can you factor this out into a helper function such as
> "check_filesystems" using 8 space tabs?

Sure, will do in v2.

Thanks,
Eryu
