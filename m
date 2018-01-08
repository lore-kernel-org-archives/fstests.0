Received: from mail-wm0-f67.google.com ([74.125.82.67]:43053 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755031AbeAHC4l (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Jan 2018 21:56:41 -0500
Received: by mail-wm0-f67.google.com with SMTP id n138so11556275wmg.2
        for <fstests@vger.kernel.org>; Sun, 07 Jan 2018 18:56:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180107153106.GO5123@eguan.usersys.redhat.com>
References: <20171101001159.88570-1-harshads@google.com> <20180104011801.10141-1-harshads@google.com>
 <CAOQ4uxguExYyi4gkDmAedgQcCSXSucG3_nP4YzT0x9AbqTNJxA@mail.gmail.com>
 <20180104082028.GA5123@eguan.usersys.redhat.com> <CAMCMpYLZNNwFUBYCUUp8NLtt7_5ui=Kv=RaOGweDv9BGWaPGsA@mail.gmail.com>
 <20180107153106.GO5123@eguan.usersys.redhat.com>
From: Harshad Shirwadkar <harshads@google.com>
Date: Sun, 7 Jan 2018 18:56:39 -0800
Message-ID: <CAMCMpY+tJK77tGfWNejfiiyn4k5U+1y7c57RaME2O0U+R-522w@mail.gmail.com>
Subject: Re: [PATCH v3] ext4/030: Ext4 online resize with bigalloc tests.
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Okay, I will keep this patch clean and will just use
_require_scratch_* functions. Let me submit another patch that does
that cleaning up that Amir suggested.

On Sun, Jan 7, 2018 at 7:31 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Fri, Jan 05, 2018 at 01:21:30PM -0800, Harshad Shirwadkar wrote:
>> On Thu, Jan 4, 2018 at 12:20 AM, Eryu Guan <eguan@redhat.com> wrote:
>> > On Thu, Jan 04, 2018 at 10:09:08AM +0200, Amir Goldstein wrote:
>> >> On Thu, Jan 4, 2018 at 3:18 AM, harshads <harshads@google.com> wrote:
>> >> > Add tests to verify Ext4 online resizing feature with bigalloc feature
>> >> > enabled. We test various resizing scenarios with different cluster
>> >> > sizes.
>> >> >
>> >> > Signed-off-by: Harshad Shirwadkar <harshads@google.com>
>> >> > ---
>> >> >  common/rc          |  23 ++++++++
>> >> >  tests/ext4/030     | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >> >  tests/ext4/030.out | 148 +++++++++++++++++++++++++++++++++++++++++++++++++
>> >> >  tests/ext4/group   |   1 +
>> >> >  4 files changed, 330 insertions(+)
>> >> >  create mode 100755 tests/ext4/030
>> >> >  create mode 100644 tests/ext4/030.out
>> >> >
>> >> > diff --git a/common/rc b/common/rc
>> >> > index 9216efdb..052dadae 100644
>> >> > --- a/common/rc
>> >> > +++ b/common/rc
>> >> > @@ -1845,6 +1845,29 @@ _require_scratch_ext4_feature()
>> >> >      _scratch_unmount
>> >> >  }
>> >> >
>> >> > +# Check whether the specified feature whether it is supported by
>> >> > +# mkfs.ext4 and the kernel by using a sparse file image.
>> >> > +_require_ext4_feature()
>> >>
>> >> 1. please explain why this loop variant is needed
>>
>> As discussed on a previous thread, the loop variant will avoid the
>> need to mkfs twice on scratch device (once in rule and once in test).
>> Also, this particular test doesn't need scratch device at all. So, if
>> I decide to use _require_scratch_ext4_feature, I will have to do
>> _require_scratch just for the rule even though the actual test doesn't
>> need scratch. So, having loop variant helps.
>
> Hmm, as the _require_scratch_ext4_feature helper is already there and
> already does mkfs twice (with a very small fs size, so the additional
> mkfs won't add much time), I think it'd be much simpler to just use
> _require_scratch and _require_scratch_feature and create all the test
> images on $SCRATCH_DEV, a loop device variant doesn't seem that
> necessary to me.
>
> Thanks,
> Eryu
>
>>
>> >> 2. it would be great if you could also change callers to
>> >> _require_scratch_ext4_feature
>> >>     to use _require_scratch_feature and plug
>> >> _require_scratch_ext4_feature in there
>>
>> Okay, that sounds good.
>>
>> >> 3. probably best to post this as a separate patch from the test itself
>>
>> Okay.
>>
>> >
>> > I haven't went through the whole patch yet, just want to point out that
>> > the _require_scratch_ext4_feature helper has been added in commit
>> > be341e36fd02 ("common: rework _require_ext4_mkfs_feature"), but not
>> > enabled in the more generic _require_scratch_feature helper yet.
>> >
>> > It'd be good to plug the ext4 helper to the generic helper in a separate
>> > patch, as Amir suggested, and perhaps converting all existing callers of
>> > the ext4 helper to the generic helper.
>> >
>> > Thanks,
>> > Eryu
>> >
>> >>
>> >> > +{
>> >> > +    if [ -z "$1" ]; then
>> >> > +        echo "Usage: _require_loop_ext4_feature feature"
>> >>
>> >> So which is it, _require_loop_ext4_feature or _require_ext4_feature?
>> >> First one sounds better to me, given that you explain why the loop
>> >> variant is needed.
>> >> If it is needed, will it be useful to have for other fs?
>> >> Then better implement _require_loop_feature and make ext4
>> >> a specific case.
>>
>> Thanks for pointing this out. I agree that _require_loop_ext4_feature
>> is better. Sure, I'll add a _require_loop_feature. Alright, I'll do
>> _require_loop stuff in a different patch.
>>
>> - Harshad.
>>
>> >>
>> >> Cheers,
>> >> Amir.
