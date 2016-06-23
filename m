Received: from mail-io0-f170.google.com ([209.85.223.170]:33423 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbcFWLXK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2016 07:23:10 -0400
Received: by mail-io0-f170.google.com with SMTP id t74so68722075ioi.0
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2016 04:23:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACj3i733G7oz_tg4NANfz_=X5nYMp31k-FskEPXxHsaSxKtTEw@mail.gmail.com>
References: <1464858659-610-1-git-send-email-jtulak@redhat.com>
 <20160607034555.GK5140@eguan.usersys.redhat.com> <CACj3i733G7oz_tg4NANfz_=X5nYMp31k-FskEPXxHsaSxKtTEw@mail.gmail.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Thu, 23 Jun 2016 13:22:49 +0200
Message-ID: <CACj3i73+Hey_jv8Y1ky_2JPdeauqEhFUWVF89tyFFH6s04ZcrQ@mail.gmail.com>
Subject: Re: [PATCH] xfstests: update xfs/096 for new behaviour
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 7, 2016 at 10:18 AM, Jan Tulak <jtulak@redhat.com> wrote:
>
>
>
> On Tue, Jun 7, 2016 at 5:45 AM, Eryu Guan <eguan@redhat.com> wrote:
>>
>> On Thu, Jun 02, 2016 at 11:10:59AM +0200, Jan Tulak wrote:
>> > Because we recently changed how mkfs behaves when it gets
>> > incorrect/invalid
>> > values, update the expected output to reflect the change.
>>
>> This will break test with old-behavior xfsprogs. But I'm not sure what
>> the best solution is..
>
>
> Hmm, well, an "if version > something" could work, together with testing the
> changed text directly in the test and making the correct output quiet.
>
> I can add something like that to xfstests and make it a function
> (has_mkfs_old_input_format) for easier use in the tests, but... It seems
> that only this single test is broken by the change, and I don't know if we
> want this backward compatibility in future tests.
>
> The only case when I see a usage would be finding a bug and then using the
> test to bisect the commit, while going over the change boundary. And will
> the persons doing this remember that there is a check for this? Or will they
> vaguely remember that there was some change and just look for the version
> and make their own "if version"?
>
> I would like a centralised solution, but I'm really afraid that it would be
> of no use. And moving the output text into the test is the only way I can
> think of for this specific test.
>
>
>>
>>
>> And it seems that generic/054 and generic/055 are failing because of the
>> same reason, if so, fix them together?
>
>
> These two tests should be fixed by the -l su minval patch, so it is just
> this one.
>

Mmm, I spent some time on this but did not figure out any nice
solution. Or... I found one, but I'm not sure how you will like it.

Making the test to comply both versions is difficult because it is not
just the error message that differs, but also that this run is now
invalid:

# test log stripe greater than LR size
 --- mkfs=-l version=2,su=266240 ---

It differs also in what should fail. So rather than making some
complicated logic, I got the idea to make a duplicity of this test.
One will run with old version and skipped on the new, the other vice
versa. Naming can utilize the text suffixes, so we would have xfs/096
and xfs/096-old-mkfs-inputs.

It is not ideal, but looks better than some in-test filtering... What
do you think?

Cheers,
Jan
-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
