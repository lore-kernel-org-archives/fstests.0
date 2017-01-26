Received: from mail-io0-f180.google.com ([209.85.223.180]:34612 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdAZHSY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Jan 2017 02:18:24 -0500
Received: by mail-io0-f180.google.com with SMTP id l66so32362999ioi.1
        for <fstests@vger.kernel.org>; Wed, 25 Jan 2017 23:18:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170126051449.GO1859@eguan.usersys.redhat.com>
References: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
 <20170126051449.GO1859@eguan.usersys.redhat.com>
From: Mike Frysinger <vapier@chromium.org>
Date: Wed, 25 Jan 2017 21:17:52 -1000
Message-ID: <CAAbOSc=atTuK_Js+TGdD37JMrWNgOj0jsbDiiNsvinrFkdwCPg@mail.gmail.com>
Subject: Re: xfstest and chromeos
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 25, 2017 at 7:14 PM, Eryu Guan wrote:
> On Mon, Jan 23, 2017 at 09:57:15AM -0800, Gwendal Grignou wrote:
>> I am adding xfstest to chromeos test image, to improve chromeos
>> filesystems test coverage.
>> Doing so, I encountered to issues, documented in
>> https://chromium-review.googlesource.com/#/c/424372
>> and
>> https://chromium-review.googlesource.com/#/c/424191
>>
>> https://chromium-review.googlesource.com/#/c/424372
>> - To circuvent SELinux protection we add a mount context option,
>> requesting to use nfs_t context. However on chromeos, we have no nfs
>> security context - we are not expecting usings nfs - leading to a
>> mount error. Shall we try to use another context or check beforehand
>> if a context is needed for mount?
>
> The selinux context is there because without it some quota or xattr
> tests will fail due to extra xattr set by selinux.
>
> I'm not sure what context works for chromeos, but I think we can make
> SELINUX_MOUNT_OPTIONS configurable, and it defaults to current value. So
> that chromeos could use any context that works for it.

that sounds fine.  something like:
  if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
    : ${SELINUX_MOUNT_OPTIONS:="-o context=system_u:object_r:nfs_t:s0"}
    export SELINUX_MOUNT_OPTIONS
  fi

>> https://chromium-review.googlesource.com/#/c/424191
>> - Chromeos needs libtool to (cross-)compile packages and put them at
>> the right place. I needed to move archived aclocal.m4 to acinclude.m4.
>> Does it make sense to require aclocal to run to compile xfstests?
>
> Sorry, I'm not that familiar with all the autotools build system.. I may
> need some time to look into it. Or someone else who is familiar with it
> could provide some inputs here?

i've long been hesitant to touch the xfs build code because it looks
like SGI/XFS peeps have spent a lot of time avoiding using autotools,
or maybe the code is so old it predates support on the autotools side.
either way, it's not clear what exactly the goal is here.

Gwendal's patch needs a bit more work, but if people are open to
depending on libtool in this way (which would fix cross-compiling
problems), then i can update his patch and send it out.
-mike
