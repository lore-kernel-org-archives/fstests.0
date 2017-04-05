Received: from mx1.redhat.com ([209.132.183.28]:54320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbdDECu2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 4 Apr 2017 22:50:28 -0400
Date: Wed, 5 Apr 2017 10:50:26 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [xfstests v4 6/8] overlay: can not change underlying immutable
 file
Message-ID: <20170405025026.GT22845@eguan.usersys.redhat.com>
References: <1487842966-30986-1-git-send-email-xzhou@redhat.com>
 <1487842966-30986-7-git-send-email-xzhou@redhat.com>
 <CAOQ4uxgz8496z_WYaKe5m-uXOFjMVmf+MfkEZG3Tf+hqj6yAUQ@mail.gmail.com>
 <CAOQ4uxgv4gzfn6SphscYsBOd3G4xq4TVMnCEZfpcxqox2uUYNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgv4gzfn6SphscYsBOd3G4xq4TVMnCEZfpcxqox2uUYNg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests <fstests@vger.kernel.org>, David Howells <dhowells@redhat.com>
List-ID: <fstests@vger.kernel.org>

[Sorry for the late response, was in public holiday]

On Tue, Apr 04, 2017 at 07:31:46PM +0300, Amir Goldstein wrote:
> On Tue, Apr 4, 2017 at 2:19 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> > On Thu, Feb 23, 2017 at 11:42 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> [...]
> >> +
> >> +# Modify as appropriate.
> >> +_supported_fs overlay
> >> +_supported_os Linux
> >> +_require_scratch
> >> +_require_chattr
> >> +
> >
> > Eryu,
> >
> > A way-post-merge bug spotting:
> > Should be "_require_chattr i".
> > _require_chattr alone makes no sense (and should probably be reported
> > as an error)
> >
> > I may get to send a fix, but not too soon..
> >
> 
> Apparently, _require_chattr with no arguments does do what it is expected to do,
> or as David wrote in the new documentation patch:
> "The test requires that the chattr command be available and supported by
> the $TEST_DEV filesystem"
> 
> But it appears to be doing the right thing by coincidence??
> Without any arguments to _require_chattr, it ends up executing
> 
> chattr + $file
> 
> and
> 
> chattr - file
> 
> The former, surprisingly does do FS_IOC_GETFLAGS and FS_IOC_SETFLAGS
> on the file, so the check is correct.
> 
> The latter spews this error into full output "Must use '-v', =, - or +"
> and ignored the failure - again correct, but seems unintentional.
> 
> I wonder if we should forbid the use of _require_chattr with no args?

I agreed. Do you mind sending a fix?

> It's only user right now is test overlay/027 and that seems like a bug
> (test should _require_chattr i).

Agreed. Xiong has acknowledged the bug, hopefully he will send a fix.

Thanks for finding this!

Eryu
