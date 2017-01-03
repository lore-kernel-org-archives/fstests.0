Received: from mail-oi0-f65.google.com ([209.85.218.65]:35978 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdACJKw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Jan 2017 04:10:52 -0500
Received: by mail-oi0-f65.google.com with SMTP id u15so69408826oie.3
        for <fstests@vger.kernel.org>; Tue, 03 Jan 2017 01:10:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170103050607.GJ1859@eguan.usersys.redhat.com>
References: <1483363379-10210-1-git-send-email-amir73il@gmail.com>
 <1483363379-10210-2-git-send-email-amir73il@gmail.com> <20170103050607.GJ1859@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Jan 2017 11:10:50 +0200
Message-ID: <CAOQ4uxjTHcOdA_F7SOCbrQq8D1_UArd7zjbxm4VjUs8n3DWCxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] check: support include/exclude of sub groups
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 3, 2017 at 7:06 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Mon, Jan 02, 2017 at 03:22:59PM +0200, Amir Goldstein wrote:
>> Allow including and/or excluding tests by test dir and group.
>> -g and -x command line arguments can take the form of
>> <subdir>/<group>.
>>
>> For example:
>>
>> ./check -n -g xfs/quick
>> ./check -n -g stress -x xfs/stress
>> ./check -n -g xfs/punch -x dangerous_fuzzers
>>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> This looks handy to me! Mention this usage in usage() function too?
>

usage() is so far behind and cryptic (what is the difference between -E and -X?)
I will send a separate patch to address these and the new subgroup as well.

> Thanks,
> Eryu
>
>> ---
>>  check | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/check b/check
>> index faf6281..8d1ec71 100755
>> --- a/check
>> +++ b/check
>> @@ -105,6 +105,14 @@ get_group_list()
>>  {
>>       local grp=$1
>>       local grpl=""
>> +     local sub=$(dirname $grp)
>> +
>> +     if [ -n "$sub" -a "$sub" != "." -a -d "$SRC_DIR/$sub" ]; then
>> +             # group is given as <subdir>/<group> (e.g. xfs/quick)
>> +             grp=$(basename $grp)
>> +             get_sub_group_list $sub $grp
>> +             return
>> +     fi
>>
>>       for d in $SRC_GROUPS $FSTYP; do
>>               if ! test -d "$SRC_DIR/$d" ; then
>> --
>> 2.7.4
>>
