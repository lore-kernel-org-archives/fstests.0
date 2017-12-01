Received: from mail-yw0-f196.google.com ([209.85.161.196]:40928 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdLAHVQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Dec 2017 02:21:16 -0500
Received: by mail-yw0-f196.google.com with SMTP id g191so3696104ywe.7
        for <fstests@vger.kernel.org>; Thu, 30 Nov 2017 23:21:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DF0589AC-18BE-495E-8DFD-54F0690CC8E7@mykernel.net>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
 <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net> <20171201041301.GB2749@eguan.usersys.redhat.com>
 <DF0589AC-18BE-495E-8DFD-54F0690CC8E7@mykernel.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 1 Dec 2017 09:21:15 +0200
Message-ID: <CAOQ4uxgOyPy9w96_HaUtM1thHcajn1LuHkiFSOtMZw0f-=HR8g@mail.gmail.com>
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Chengguang Xu <cgxu@mykernel.net>
Cc: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 1, 2017 at 8:38 AM, Chengguang Xu <cgxu@mykernel.net> wrote:
>
>> =E5=9C=A8 2017=E5=B9=B412=E6=9C=881=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=881=
2:13=EF=BC=8CEryu Guan <eguan@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Fri, Dec 01, 2017 at 12:04:44PM +0800, Chengguang Xu wrote:
>>> Hi Eryu,
>>>
>>> Actually, in my another test case generic/470 will need to check whethe=
r fs supports syncfs or not.
>>> I make shared infrastructure for checking that, and because it is commo=
n component
>>> I post as an individual patch instead of including in the case of gener=
ic/470.
>>
>> I think "_require_xfs_io_command syncfs" should be fine, there's no need
>> & not encouraged to add new binary & usage like this. If you want to run
>> syncfs(2) to make sure the kernel actually supports it, you can add a
>> new 'syncfs' switch case in _require_xfs_io_command.
>>
>
> Failure of _require_xfs_io_command check leads to notrun, if we have seve=
ral
> sync patterns(combination of fsync/fdatasync/syncfs/sync) in an actual te=
st case,
> the case will lose downward compatibility for old kernel.
> In this situation, we have to split test case though they look similar.
>

You have 2 options:
Easy - split 2 tests - 1 requires syncfs and tests syncfs, 1 does not
require and does not test syncfs
Work - re-factor  _require_xfs_io_command to _check_xfs_io_command
that returns the error
message but does not _notrun. use that hepler in your test to
conditionally test syncfs.

Anyway, I see people are not so fond of the delalloc "canary test".
Perhaps a still simple and quick test would be to do small buffered
write; sync; small direct io read?
This test can still pass sometimes for buggy fs, but that will always
be a problem with verifying
that 'our' sync call did the job and not another thread in the system.

Amir.
