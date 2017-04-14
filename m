Received: from mga03.intel.com ([134.134.136.65]:4137 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751612AbdDNPvU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 14 Apr 2017 11:51:20 -0400
Date: Fri, 14 Apr 2017 09:51:03 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v3 2/4] generic: test mmap io fom DAX to non-DAX
Message-ID: <20170414155103.GA9972@linux.intel.com>
References: <20170412062608.y2u5og3xz2oly44b@XZHOUW.usersys.redhat.com>
 <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492008380-29164-3-git-send-email-xzhou@redhat.com>
 <20170413041157.rcctxishunypgtvv@XZHOUW.usersys.redhat.com>
 <CAPcyv4iEk2BVq=W=Dd36Dfra7WD2LpGT0FV4afFU4HuOfzdFmQ@mail.gmail.com>
 <20170414100134.iqqou7chjsctpfwh@XZHOUW.usersys.redhat.com>
 <CAPcyv4jbM2Kb4pZtyihrX=ZME+mTr5+vLN6PO-31o9jyaPPwMg@mail.gmail.com>
 <20170414152233.GA5223@linux.intel.com>
 <CAPcyv4gKv4mXoh-=-O6ZadW25i5sPKM1EyZqcCAz_cEg-zBM3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gKv4mXoh-=-O6ZadW25i5sPKM1EyZqcCAz_cEg-zBM3Q@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, jmoyer <jmoyer@redhat.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 14, 2017 at 08:33:44AM -0700, Dan Williams wrote:
> On Fri, Apr 14, 2017 at 8:22 AM, Ross Zwisler
> <ross.zwisler@linux.intel.com> wrote:
> > On Fri, Apr 14, 2017 at 07:49:48AM -0700, Dan Williams wrote:
> >> On Fri, Apr 14, 2017 at 3:01 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> >> > I agree with Ross that we don't even need ndctl and jq, if we run tests
> >> > on memmap setup.
> >>
> >> I don't understand this comment. How is the test determining if it is
> >> on an memmap defined namespace without querying sysfs?
> >
> > If we we assume that a setup is *either* memmap based or NFIT based, we can
> > choose whether to use jq & ndctl by grepping for "memmap" with a trailing "!"
> > in /proc/cmdline.
> >
> > If you think we need to worry about the case where users have both a valid
> > NFIT and a memmap kernel command line param making them a PMEM region, this
> > shortcut won't work.
> 
> Since the user is picking the pmem device the test will gave the wrong
> answer if they pick the wrong one. Especially since the kernel is
> growing new nvdimm bus types, like the powerpc one, this test should
> check the namespace mode.

Fair enough.
