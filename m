Received: from mail-pg1-f196.google.com ([209.85.215.196]:45190 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfAKFka (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Jan 2019 00:40:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so5830901pgc.12
        for <fstests@vger.kernel.org>; Thu, 10 Jan 2019 21:40:30 -0800 (PST)
Date: Fri, 11 Jan 2019 13:40:23 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 1/2] fsstress: add splice support
Message-ID: <20190111054023.GD2713@desktop>
References: <20190110082516.22526-1-zlang@redhat.com>
 <20190110140113.GA2713@desktop>
 <20190111033117.GV30999@dhcp-12-149.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111033117.GV30999@dhcp-12-149.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 11, 2019 at 11:31:17AM +0800, Zorro Lang wrote:
> On Thu, Jan 10, 2019 at 10:01:13PM +0800, Eryu Guan wrote:
> > On Thu, Jan 10, 2019 at 04:25:15PM +0800, Zorro Lang wrote:
> > > Support the splice syscall in fsstress.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > > 

<snap>

> > > +	if (ret1 < 0 || ret2 < 0)
> > > +		e = errno;
> > > +	else
> > > +		e = 0;
> > > +	if (v1 || v2) {
> > > +		printf("%d/%d: splice %s%s [%lld,%lld] -> %s%s [%lld,%lld]",
> > 
> > Better to print out error number on success (0) too, to be consistent
> > with other operations.
> 
> Hmm... it's not consistent for all, likes clonerange_f, copyrange_f and
> deduperange_f don't print out error number on success (0), do you need I change
> them to keep consistent too, as you're asking for that now?

That'd be great (but we can do that in a separate patch)! I think it's
easier to parse fsstress log when tracing down bugs if the log follows
similar formats.

Thanks,
Eryu
