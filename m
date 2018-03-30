Received: from mail-pg0-f50.google.com ([74.125.83.50]:40327 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeC3A6U (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Mar 2018 20:58:20 -0400
Date: Fri, 30 Mar 2018 08:58:13 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: test btrfs fsync after hole punching with
 no-holes mode
Message-ID: <20180330005813.GL30836@localhost.localdomain>
References: <20180326225921.10096-1-fdmanana@kernel.org>
 <20180328021753.GE30836@localhost.localdomain>
 <CAL3q7H4FqvoVs69mfWFh1M=8bDZ5FSHcq0KKg+g0C5HcjLuXwg@mail.gmail.com>
 <20180328103358.GG30836@localhost.localdomain>
 <CAL3q7H7f8gVSitTudAopognpru9LRtoTJfm+8D-N0SYtiWeZpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7f8gVSitTudAopognpru9LRtoTJfm+8D-N0SYtiWeZpA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 29, 2018 at 02:45:26PM +0100, Filipe Manana wrote:
> On Wed, Mar 28, 2018 at 11:33 AM, Eryu Guan <guaneryu@gmail.com> wrote:
> > On Wed, Mar 28, 2018 at 09:48:17AM +0100, Filipe Manana wrote:
> >> On Wed, Mar 28, 2018 at 3:17 AM, Eryu Guan <guaneryu@gmail.com> wrote:
> >> > On Mon, Mar 26, 2018 at 11:59:21PM +0100, fdmanana@kernel.org wrote:
> >> >> From: Filipe Manana <fdmanana@suse.com>
> >> >>
> >> >> Test that when we have the no-holes mode enabled and a specific metadata
> >> >> layout, if we punch a hole and fsync the file, at replay time the whole
> >> >> hole was preserved.
> >> >>
> >> >> This issue is fixed by the following btrfs patch for the linux kernel:
> >> >>
> >> >>   "Btrfs: fix fsync after hole punching when using no-holes feature"
> >> >
> >> > I'd expect a test failure with 4.16-rc6 kernel, as the mentioned fix
> >> > above is not there. But test always passes for me. Did I miss anything?
> >> > btrfs-progs version is btrfs-progs-4.11.1-3.fc27.
> >>
> >> It should fail on any kernel, with any btrfs-progs version (which
> >> should be irrelevant).
> >> Somehow on your system we are not getting the specific metadata layout
> >> needed to trigger the issue.
> >>
> >> Can you apply the following patch on top of the test and provide the
> >> result 159.full file?
> >>
> >> https://friendpaste.com/6xAuLeN4xl1AGjO9Qc5I8L
> >>
> >> So that I can see what metadata layout you are getting.
> >> Thanks!
> >
> > Sure, please see attachment.
> 
> Thanks!
> So you indeed get a different metadata layout, and that is because you
> have SELinux enabled which causes some xattr to be added to the test
> file (foobar):
> 
>         item 6 key (257 XATTR_ITEM 3817753667) itemoff 64932 itemsize 83
>                 location key (0 UNKNOWN.0 0) type XATTR
>                 transid 7 data_len 37 name_len 16
>                 name: security.selinux
>                 data unconfined_u:object_r:unlabeled_t:s0
> 
> I can make the test work with and without selinux enabled (by punching
> holes on a few extents that are candidates to be at leaf boundaries).
> Is it worth it? (I assume most people run the tests without selinux)

Yes, please make it work with selinux if possible (but if that requires
too much complexity, we can give it a second thought).

I'm not sure about others, but I run fstests with selinux almost all the
time, because Fedora/RHEL distros have selinux on by default :) so are
all other people using Fedora/RHEL/Centos as test hosts, I guess.

Thanks,
Eryu
