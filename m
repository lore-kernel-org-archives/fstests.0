Received: from mail-oi0-f44.google.com ([209.85.218.44]:34581 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbdDDQbr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Apr 2017 12:31:47 -0400
Received: by mail-oi0-f44.google.com with SMTP id d2so36375979oig.1
        for <fstests@vger.kernel.org>; Tue, 04 Apr 2017 09:31:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgz8496z_WYaKe5m-uXOFjMVmf+MfkEZG3Tf+hqj6yAUQ@mail.gmail.com>
References: <1487842966-30986-1-git-send-email-xzhou@redhat.com>
 <1487842966-30986-7-git-send-email-xzhou@redhat.com> <CAOQ4uxgz8496z_WYaKe5m-uXOFjMVmf+MfkEZG3Tf+hqj6yAUQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Apr 2017 19:31:46 +0300
Message-ID: <CAOQ4uxgv4gzfn6SphscYsBOd3G4xq4TVMnCEZfpcxqox2uUYNg@mail.gmail.com>
Subject: Re: [xfstests v4 6/8] overlay: can not change underlying immutable file
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>, Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, David Howells <dhowells@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 4, 2017 at 2:19 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Thu, Feb 23, 2017 at 11:42 AM, Xiong Zhou <xzhou@redhat.com> wrote:
[...]
>> +
>> +# Modify as appropriate.
>> +_supported_fs overlay
>> +_supported_os Linux
>> +_require_scratch
>> +_require_chattr
>> +
>
> Eryu,
>
> A way-post-merge bug spotting:
> Should be "_require_chattr i".
> _require_chattr alone makes no sense (and should probably be reported
> as an error)
>
> I may get to send a fix, but not too soon..
>

Apparently, _require_chattr with no arguments does do what it is expected to do,
or as David wrote in the new documentation patch:
"The test requires that the chattr command be available and supported by
the $TEST_DEV filesystem"

But it appears to be doing the right thing by coincidence??
Without any arguments to _require_chattr, it ends up executing

chattr + $file

and

chattr - file

The former, surprisingly does do FS_IOC_GETFLAGS and FS_IOC_SETFLAGS
on the file, so the check is correct.

The latter spews this error into full output "Must use '-v', =, - or +"
and ignored the failure - again correct, but seems unintentional.

I wonder if we should forbid the use of _require_chattr with no args?
It's only user right now is test overlay/027 and that seems like a bug
(test should _require_chattr i).
