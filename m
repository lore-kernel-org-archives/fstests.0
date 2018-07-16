Received: from mx1.redhat.com ([209.132.183.28]:43344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbeGPIi4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Jul 2018 04:38:56 -0400
Date: Mon, 16 Jul 2018 16:12:43 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/062: filter redundant output by getfattr
Message-ID: <20180716081243.GI4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180712155926.21722-1-zlang@redhat.com>
 <20180713063925.GA2830@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713063925.GA2830@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 13, 2018 at 02:39:25PM +0800, Eryu Guan wrote:
> On Thu, Jul 12, 2018 at 11:59:26PM +0800, Zorro Lang wrote:
> > When getfattr dumps values of all extended attributes (-d option),
> > it doesn't print empty extended attributes. e.g: user.name. But
> > from attr-2.4.48 this behavior is changed,  new getfattr prints
> > user.name="".
> > 
> > The {=""} will break the golden image, so filter the redundant =""
> > at the end if it has.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Hi,
> > 
> > This's a bad news. Latest attr package attr-2.4.48 changed his
> > behavior as above. And this's different with attr-2.4.47.
> > 
> > With old attr:
> > # setfattr -h -n user.name testfile
> > # getfattr -d -n user.name testfile                                                                                                                                     
> > # file: testfile                               
> > user.name
> > 
> > With new attr:
> > # setfattr -h -n user.name testfile
> > # getfattr -d -n user.name testfile                                                                                                                                     
> > # file: testfile                               
> > user.name=""
> > 
> > Note: -d option is necessary
> > 
> > This little difference will break golden image. So this's the problem.
> > If you have better idea than this patch, please tell me.
> > 
> > Thanks,
> > Zorro
> > 
> > 
> >  tests/generic/062 | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/062 b/tests/generic/062
> > index df67960d..4fc2dc46 100755
> > --- a/tests/generic/062
> > +++ b/tests/generic/062
> > @@ -29,9 +29,13 @@ _cleanup()
> >  }
> >  trap "_cleanup; exit \$status" 0 1 2 3 15
> >  
> > +# When getfattr dump values of all extended attributes, it print empty attr
> > +# as user.name before, but new getfattr print it as user.name="". For match
> > +# the golden image, filter the redundant ="" at the end.
> >  getfattr()
> >  {
> > -    $GETFATTR_PROG --absolute-names -dh $@ 2>&1 | _filter_scratch
> > +    $GETFATTR_PROG --absolute-names -dh $@ 2>&1 | _filter_scratch | \
> > +	sed -e 's/=\"\"//'
> >  }
> 
> This should really be done by a new helper function that hides all the
> details, so future tests could just take use of the helper.

OK. So how about a common function named _getfattr in common/attr, to instead
of all $GETFATTR_PROG (or just g/062).

Or a a common function named _filter_getfattr, to filter some $GETFATTR_PROG
output if a case need it.

_getfattr()
{
	$GETFATTR_PROG $@ 2>&1 | _filter_testdir_and_scratch | \
		sed -e 's/=\"\"//'
}

Or

_filter_getfattr()
{
	_filter_testdir_and_scratch | sed -e 's/=\"\"//'
}

Thanks,
Zorro

> 
> Thanks,
> Eryu
> 
> >  
> >  setfattr()
> > -- 
> > 2.14.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
