Received: from mx2.suse.de ([195.135.220.15]:41430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbfADJyO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Jan 2019 04:54:14 -0500
Subject: Re: [PATCH] common/config: Always create RESULT_BASE
References: <20190103100135.24748-1-nborisov@suse.com>
 <d8faa1f5-87db-b029-4e68-68d76f7c410a@suse.com>
 <20190103215609.GU6311@dastard> <20190104094330.GB2803@desktop>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <80d52fec-6735-1450-6e4c-8e4d13d51dc7@suse.com>
Date: Fri, 4 Jan 2019 11:54:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190104094330.GB2803@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>



On 4.01.19 =D0=B3. 11:43 =D1=87., Eryu Guan wrote:
> On Fri, Jan 04, 2019 at 08:56:09AM +1100, Dave Chinner wrote:
>> On Thu, Jan 03, 2019 at 02:29:08PM +0200, Nikolay Borisov wrote:
>>>
>>>
>>> On 3.01.19 =D0=B3. 12:01 =D1=87., Nikolay Borisov wrote:
>>>> Commit 7fc034868d5d ("common/config: create $RESULT_BASE before dump=
ing kmemleak leaks")
>>>> inadvertently broke $RESULT_BASE dir creation since it changed the l=
ogic
>>>> to only create the directory only if this variable is not explicitly=
 set
>>>> by the user. Fix this by ensuring RESULT_BASE is always created.
>>>>
>>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>>
>>> Eryu,
>>>
>>> I think Johannes' commit should actually be reverted. Currently
>>> get_next_config is called at the beginning of the section code _AFTER=
_
>>> _init_kmemleak so it's not really fixing the problem that Johannes
>>> described. So care to revert his commit ?
>>
>> Yes, the original commit should be reverted. Using RESULT_BASE in
>> the way that init_kmemleak is using it is fundamentally broken.
>> Using RESULTS_BASE is incorrect - harness run state is supposed to
>> be stored in the section-aware RESULTS_DIR (e.g. see
>> _require_scratch()) which is constant and always exists for each
>> section that is run.
>>
>> The code was architectected this way because section definitions can
>> change RESULT_BASE, and that means the RESULT_BASE defined when
>> init_kmemleak() is called may not point to the same location as when
>> check_memleak() is called. Hence check_memleak will never run if a
>> section definition changes RESULT_BASE.
>>
>> IOWs, the init_kmemleak() call needs to be done inside the
>> section iteration loop, after the section config has been parsed and
>> we've determined if the the section will be run. This is where the
>> original code created RESULT_BASE if it didn't exist. Further, all
>> the section run state is then stored in RESULTS_DIR, which is
>> created from the current RESULT_BASE (e.g. see _require_scratch,
>> check_dmesg, etc).
>=20
> This makes more sense, thanks for the suggestion!
>=20
>>
>> Hence init_kmemleak() and check_kmemleak() should have a scope
>> inside a valid RESULT_DIR path. And once this is done, you can then
>> add a USE_KMEMLEAK section variable to turn kmemleak detection on
>> and off via the config file on a per-section basis.....
>>
>> So, IMO, the correct thing to do here is revert the original broken
>> change and fix the kmemleak infrastructure to be properly aware of
>> config sections.
>=20
> I think we can take Nikolay's patch for now so we don't leave
> user-specified RESULT_BASE not created for any longer, and revert it an=
d
> 7fc034868d5d when we rework kmemleak infrastructure.

Actually no, for the following RESULT_BASE pattern:=20
RESULT_BASE=3D"$PWD/results/$HOST/$(uname -r)"/$(date +%Y-%m-%d-%H-%M-%N)=
/


Running a test I can see the following mkdirs happening:=20

created RESULT_BASE: /root/xfstests-dev/results/linux/4.12.14-nikbor/2019=
-01-04-09-48-027249346/
created RESULT_BASE: /root/xfstests-dev/results/linux/4.12.14-nikbor/2019=
-01-04-09-48-093731409/
created RESULT_BASE: /root/xfstests-dev/results/linux/4.12.14-nikbor/2019=
-01-04-09-48-093731409/

In my case for every test run it potentially creates 2 directories, where=
 only one is really=20
populated with data. This is no good. I will strongly suggest that you re=
vert the original patch and=20
let kmemleak be broken rather than piling hacks (which have funky side ef=
fects as I have shown above)
or leaving dir creation broken altogether.

While at it you might also consider reverting 074740a32c6a36c5ba7d4be66dd=
4ee63e9f744f3 until Darick=20
(or anyone else interested) properly integrated kmemleak support.=20



>=20
> Thanks,
> Eryu
>=20
