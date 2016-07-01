Received: from mail-it0-f48.google.com ([209.85.214.48]:38746 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbcGAMNQ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 1 Jul 2016 08:13:16 -0400
Received: by mail-it0-f48.google.com with SMTP id h190so15474063ith.1
        for <fstests@vger.kernel.org>; Fri, 01 Jul 2016 05:13:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160701030537.GO23649@eguan.usersys.redhat.com>
References: <1464858659-610-1-git-send-email-jtulak@redhat.com>
 <1467195535-32147-1-git-send-email-jtulak@redhat.com> <20160630065459.GW23649@eguan.usersys.redhat.com>
 <20160701003700.GU27480@dastard> <20160701030537.GO23649@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Fri, 1 Jul 2016 14:12:56 +0200
Message-ID: <CACj3i70iqBT9vmbMOj3V+YUEFyNPv-sAD6Z+ctCzgh-QrEjaZA@mail.gmail.com>
Subject: Re: [PATCH v2] xfstests: update xfs/096 for new behaviour
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 1, 2016 at 5:05 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Fri, Jul 01, 2016 at 10:37:00AM +1000, Dave Chinner wrote:
>> On Thu, Jun 30, 2016 at 02:54:59PM +0800, Eryu Guan wrote:
>> > On Wed, Jun 29, 2016 at 12:18:55PM +0200, Jan Tulak wrote:
>> > > Because we recently changed how mkfs behaves when it gets incorrect/invalid
>> > > values, update the expected output to reflect the current status.
>> > > However, keep also compatibility with the old version.
>> > >
>> > > Signed-off-by: Jan Tulak <jtulak@redhat.com>
>> > > ---
>> > > CHANGE: added compatibility for the old xfsprogs.
>> >
>> > Sorry for the late response, because I was lost on this :)
>> >
>> > Hi Dave - what's the rule/policy of maintaining the backword
>> > compatibility in fstests?
>>
>> We try to ensure that tests that work/pass on old versions of
>> utilities continue to do so, even as the newer code changes. If the
>> new code changes too much, then we can either stop running the test
>> on older code, or we fork the test for the new code....
>
> Thanks Dave for the clarification!
>
>>
>> > I know that efforts have been made to make
>> > sure new changes don't break old binaries, but is that a must or a
>> > best-to-have? And what do you think about the xfsprogs version
>> > comparing? (I'm OK with it :-))
>>
>> We've tried to avoid using version numbers for comparisons, because
>> that becomes a downward spiral into a mess. Instead, we have
>> gone down the path of testing for supported features in binaries and
>> filesystems, not checking version numbers. i.e. we don't care about
>> the version number - we care about the feature that the binary
>> provides. Those checks are self documenting - the test tells use
>> what it requires which something that version number checks do not
>> explain at all.
>

OK, thanks for explaining it.

>
>>
>> In this case, we have a change in a binary that turns warnings into
>> errors or issues errors rather than silently ignores what the user
>> asked for and uses defaults. We already filter out anything relevant
>> from the result to support all the changes in binary output since
>> the test was introduced, so we really can't tell if the value
>> substitution behaviour has changed anymore. IOWs, this test really
>> isn't serving much purpose as a regression test anymore.
>>
>> From that perspective, I'd say we either remove it or we stop trying
>> to update it further by adding a new requires check for an old mkfs
>> binary that silently accepts invalid log stripe unit sizes. i.e.
>> don't add version number checks, add a feature check so that it only
>> runs on old mkfs binaries but not new ones. e.g.
>> _require_mkfs_accept_invalid_log_sunit()

All right. I think that the feature check should remain in the test,
at least until there are more tests where this is needed and there is
a clear idea what features are useful to have a check for. But other
than that, I agree.

>
> This looks good to me.
>
> Hi Jan - Can you please send an updated version as Dave suggested above?
> And I think the input-validation test could be updated as well to make
> it only run on newer mkfs.
>

Yes, I will send both.

Cheers,
Jan



-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
