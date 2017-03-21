Received: from cn.fujitsu.com ([59.151.112.132]:33143 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757070AbdCUIbs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Mar 2017 04:31:48 -0400
Subject: Re: [PATCH] fstests: generic/407: Use _reflink_range to avoid old
 xfs_io bug
References: <20170321075321.17943-1-quwenruo@cn.fujitsu.com>
 <20170321082047.GW14226@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <df63ad5a-d478-642c-bc06-fbc11bb38778@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 16:31:30 +0800
In-Reply-To: <20170321082047.GW14226@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 03/21/2017 04:20 PM, Eryu Guan wrote:
> On Tue, Mar 21, 2017 at 03:53:21PM +0800, Qu Wenruo wrote:
>> Old xfs_io has a bug that even its man page shows that reflink can accept
>> one parameter, but in fact xfs_io reflink still needs full 4 parameters.
>>
>> In this test case, it only needs to reflink the file and we know the
>> size of the file, so use _reflink_range() to replace open-coded reflink,
>> which makes the test case pass even its xfs_io is a little old and
>> doesn't accept single parameter.
>
> IMO, you need to update your xfsprogs or fix the xfs_io bug (if it's not
> fixed yet). I think there's nothing wrong with the test (unless the bug
> won't be fixed in near future and blocks the test), it runs and finds a
> bug for you :)

Yes I know it's a bug of my test environment.

But using _reflink_range won't cause anything wrong, and can make old=20
xfsprogs (not too old, v4.9.0 from Fedora 25) happy.

Despite that, using _reflink_range to replace open-coded reflink is a=20
quite valid cleanup for me.

Thanks,
Qu
>
> Thanks,
> Eryu
>
>>
>> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
>> ---
>>  tests/generic/407 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/407 b/tests/generic/407
>> index 1103d40..7d5a865 100755
>> --- a/tests/generic/407
>> +++ b/tests/generic/407
>> @@ -65,7 +65,7 @@ echo "before clone: $mtime1 $ctime1" >> $seqres.full
>>
>>  # clone to trigger timestamp change
>>  sleep 1
>> -$XFS_IO_PROG -c "reflink $sourcefile " $destfile >> $seqres.full
>> +_reflink_range $sourcefile 0 $destfile 0 4k >> $seqres.full
>>
>>  # sample and verify that timestamps have changed.
>>  mtime2=3D`stat -c %Y $destfile`
>> --
>> 2.9.3
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhtt=
p-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwICaQ&c=3DRoP1YumCXCgaWHvl=
ZYR8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE=
&m=3D01rqRm_LbgqHMfgs1jHfv8J0RTD8dmPjhwr70MmBcFQ&s=3D-tmqLqvgDCt99yGk4dZR3z=
Y6y4cKTt8XVb-P8tpZnUw&e=3D=20
>
>


--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwICaQ&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3D01rqRm_LbgqHMfgs1jHfv8J0RTD8dmPjhwr70MmBcFQ&s=3D-tmqLqvgDCt99yGk4dZR3zY6=
y4cKTt8XVb-P8tpZnUw&e=3D=20
