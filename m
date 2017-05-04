Received: from mx1.redhat.com ([209.132.183.28]:43084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbdEDH5E (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 May 2017 03:57:04 -0400
Date: Thu, 4 May 2017 15:57:02 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: attr: add support for cephfs
Message-ID: <20170504075702.GL7250@eguan.usersys.redhat.com>
References: <20170503105413.8314-1-lhenriques@suse.com>
 <20170504032340.GH7250@eguan.usersys.redhat.com>
 <CAAM7YAnOZW0xcOhMgnG_O3Wdy1SktKgRyr09jd7v1cupCTQ=Ow@mail.gmail.com>
 <20170504050006.GI7250@eguan.usersys.redhat.com>
 <CAAM7YA=rCf_y1r8+SwWL9rpjEnFrfBg5Y6oQMqokXuH7-PPHsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAM7YA=rCf_y1r8+SwWL9rpjEnFrfBg5Y6oQMqokXuH7-PPHsw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

[cc'ed fstests list]

On Thu, May 04, 2017 at 03:49:27PM +0800, Yan, Zheng wrote:
> On Thu, May 4, 2017 at 1:00 PM, Eryu Guan <eguan@redhat.com> wrote:
> > On Thu, May 04, 2017 at 11:44:46AM +0800, Yan, Zheng wrote:
> >> On Thu, May 4, 2017 at 11:23 AM, Eryu Guan <eguan@redhat.com> wrote:
> >> > On Wed, May 03, 2017 at 11:54:13AM +0100, Luis Henriques wrote:
> >> >> Block size for cephfs is 4M, which makes generic/020 test fail as the
> >> >> value for MAX_ATTRS and MAX_ATTRVAL_SIZE will be too high.  Restrict these
> >> >> two variables to sane values for this FSTYP.
> >> >>
> >> >> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> >> >
> >> > Thanks for the patch! I'd like some reviews from ceph developers on the
> >> > ceph MAX_ATTRS and MAX_ATTRVAL_SIZE numbers.
> >> >
> >>
> >> Currently we don't have any limitation on single xattr size and number
> >> of xattrs. But single xattr size is limited to 65536 by kernel.
> >
> > Thanks! Can I take it as a Reviewed-by tag?
> 
> 
> yes

Thanks!

Eryu
