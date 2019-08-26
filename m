Received: from mx1.redhat.com ([209.132.183.28]:37672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfHZGsv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Aug 2019 02:48:51 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BB19121D
        for <fstests@vger.kernel.org>; Mon, 26 Aug 2019 06:48:51 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id i4so9208909wri.1
        for <fstests@vger.kernel.org>; Sun, 25 Aug 2019 23:48:51 -0700 (PDT)
Date: Mon, 26 Aug 2019 08:48:47 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] t_stripealign: Fix fibmap error handling
Message-ID: <20190826064846.vx5jb7ugrsxyd34x@pegasus.maiolino.io>
References: <20190823092530.11797-1-cmaiolino@redhat.com>
 <20190823143650.GI1037350@magnolia>
 <20190825134154.GB2622@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825134154.GB2622@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Aug 25, 2019 at 09:41:54PM +0800, Eryu Guan wrote:
> On Fri, Aug 23, 2019 at 07:36:50AM -0700, Darrick J. Wong wrote:
> > On Fri, Aug 23, 2019 at 11:25:30AM +0200, Carlos Maiolino wrote:
> > > FIBMAP only returns a negative value when the underlying filesystem does
> > > not support FIBMAP or on permission error. For the remaining errors,
> > > i.e. those usually returned from the filesystem itself, zero will be
> > > returned.
> > > 
> > > We can not trust a zero return from the FIBMAP, and such behavior made
> > > generic/223 succeed when it should not.
> > > 
> > > Also, we can't use perror() only to print errors when FIBMAP failed, or
> > > it will simply print 'success' when a zero is returned.
> > > 
> > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > > ---
> > >  src/t_stripealign.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/src/t_stripealign.c b/src/t_stripealign.c
> > > index 5cdadaae..164831f8 100644
> > > --- a/src/t_stripealign.c
> > > +++ b/src/t_stripealign.c
> > > @@ -76,8 +76,11 @@ int main(int argc, char ** argv)
> > >  		unsigned int	bmap = 0;
> > >  
> > >  		ret = ioctl(fd, FIBMAP, &bmap);
> > > -		if (ret < 0) {
> > > -			perror("fibmap");
> > > +		if (ret <= 0) {
> > > +			if (ret < 0)
> > > +				perror("fibmap");
> > > +			else
> > > +				fprintf(stderr, "fibmap error\n");
> > 
> > "fibmap returned no result"?
> 
> Fixed on commit. Thanks!

TZ discrepancy. Thanks for fixing it on commit Eryu :)


> 
> Eryu

-- 
Carlos
