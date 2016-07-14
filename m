Received: from mail-io0-f177.google.com ([209.85.223.177]:32957 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbcGNI5L (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 14 Jul 2016 04:57:11 -0400
Received: by mail-io0-f177.google.com with SMTP id 38so69814905iol.0
        for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 01:57:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160713122859.GV2432@eguan.usersys.redhat.com>
References: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
 <1468229169-24045-5-git-send-email-jtulak@redhat.com> <20160713122859.GV2432@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Thu, 14 Jul 2016 10:56:51 +0200
Message-ID: <CACj3i70SBt=4pF3EFdTFnhYE6JPtS78dpBNqk0PntTpnX8z1aQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] xfstests: filename handling - fix early wildcard expansion
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, "Chinner, Dave" <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 13, 2016 at 2:28 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Mon, Jul 11, 2016 at 11:26:09AM +0200, Jan Tulak wrote:
>> Add quotation marks around the wildcarded name.
>
> This makes no difference for me, the original code is working well. Did
> I miss anything?
>
> [root@dhcp-66-86-11 xfstests]# bname=999
> [root@dhcp-66-86-11 xfstests]# find tests/xfs -name "$bname*"
> tests/xfs/999-test-case
> tests/xfs/999-test-case.out
> [root@dhcp-66-86-11 xfstests]# find tests/xfs -name $bname*
> tests/xfs/999-test-case
> tests/xfs/999-test-case.out
>

Hmmm. The move of the code alone was not enough to fix an issue I had,
but now I can't remember when it happened, no matter what. :( I'm
beginning to think I might forget to save the file after moving the
code. In which case...

So either drop it and if it appears again, then I will resubmit, or
keep it there "just to be sure". I'm OK with both these options, so
whatever is more in line with your idea of a clean repo. :-)

Thanks,
Jan

> Thanks,
> Eryu
>
>>
>> Signed-off-by: Jan Tulak <jtulak@redhat.com>
>> ---
>>  check | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/check b/check
>> index 58d8869..5ff897b 100755
>> --- a/check
>> +++ b/check
>> @@ -548,7 +548,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
>>               # and the test has a name. A bit of hassle to find really
>>               # the test and not its sample output or helping files.
>>               bname=$(basename $seq)
>> -             full_seq=$(find $(dirname $seq) -name $bname* -executable |
>> +             full_seq=$(find $(dirname $seq) -name "$bname*" -executable |
>>                   awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
>>                       END { print shortest }')
>>               if [ -f $full_seq ] \
>> --
>> 2.5.5
>>



-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
