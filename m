Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2BDC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Sep 2021 23:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9387B60FA0
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Sep 2021 23:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhILX3c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Sep 2021 19:29:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50938 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbhILX3c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Sep 2021 19:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631489297; x=1663025297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OySFdctbFXBXwjvYqkfOo+DkJKHS4ceqFcGWu9zUqSo=;
  b=ZVsSCc5jUCMjJxx2/qxNNVop9yARfThdUCAOAVO+T9LzlfL/iDh43o5Y
   HNVKo53uzWD7WirvImNQw3by7NAeRPetN74dsWYJOfpxpLj+TsS3Cxayf
   aJ5qfucrvXbxpE2jXefPFj+Bab1iAy2Pi58z5D/l2dpSHNHBJy+i61vmK
   u8OVn36OivDl1McXeLaDDbh3e7+Y10CKHQsEWW6noAbeYrGNhZvvbpyc2
   L94pyQxUK6kr9mUC2HK4bUDyswogOcQlHT9XyQ8mWtoSijP1Reab1Cqy1
   FXACA/0j9oMHa+cRcMhM4x8wIYm3IVMgkuHGjoQqa3X4wZUEIJ6bt/ZnC
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,288,1624291200"; 
   d="scan'208";a="291419925"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2021 07:28:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rcgd85GVDTwUSpuolQ20SQ3TiUt6eQCEqTlbNnBoAx/kzrP3sqBFr2NyffXeKtdj+Zq/58XH2Pa0dK5eUlZJeiOqA2HFDQ9YjhuumHefIc2uFSSgpYkUUN1fPLyFKxrQptT1xZTAJQbGSIU8KSEpfa/bK4FZ/vjQBBNlZmOLmVl1F0tVFb61dz/HCXnInhSzMR1Voc9NiI8hY6edoCdcu2js64PeSI+K/059SMl2TvD0m+Yh8RfDNSRZOMTDvRpHwvZnN+9Tkh9Q8SjGgM1kSLa/rz5ffYqp2XSw+NBBQLmic0NC4KU9FGGePjZlNVXkhDvBZl4i4C0AoPcVTPMUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XJ6qzgEg1YFdrgoNeuXW01/OkXhdT7upEkdETqWUTSs=;
 b=PrSYTZOZV6KK2R7hVEXPeI255vWu2MXw+gsPUsKoVBr93V+L3FoGnNmwZbqoY7vzTEtRrn4iMPSW3BQgTPj9Vwa6lMWV2kJMFilWLPLenEKkcHeeR57yC/3eUX3Tovpb0Zx8q4nuB3UamIq4sDfarEs5nYnazvGaerOKrGFyv1SGtx0INWcjBLKcJkJGWkILBo7vgDd8SpmSfE+jcCC3w+O/jVVk6u5KsgEAIIbIdZ3ZCZOtgXxKH+6E9ekU6GDQ0wLvlJshpPb5d2uTvE6szP2CIcHyzQf2+3Om1YxH4CGEYd9GQUPk4XNVtfTCuxwZSvkMC+kjDNd4J56GPPG11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ6qzgEg1YFdrgoNeuXW01/OkXhdT7upEkdETqWUTSs=;
 b=XPBggSWZGSYntWb3hvIGSlxqZf2I4u2XpbJIpWg4CpqakGdZ9xv4vbsC/H0qDkcYMi/BCzWQjEXs05b2O6HXYfN/l0UqguIqeNkbd+eUs6b7ojezxbKVb6g0HbFktcocoo6tns8moVDRU6Z2hmYtiNr5FM7U/Z3wYJ+PUi488VE=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB5544.namprd04.prod.outlook.com (2603:10b6:a03:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Sun, 12 Sep
 2021 23:28:14 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79%5]) with mapi id 15.20.4500.018; Sun, 12 Sep 2021
 23:28:14 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Eryu Guan <guan@eryu.me>
CC:     Dave Chinner <david@fromorbit.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 3/3] common/rc: Check call order of _require_dm_target
 and _require_scratch*
Thread-Topic: [PATCH v2 3/3] common/rc: Check call order of _require_dm_target
 and _require_scratch*
Thread-Index: AQHXpIzA8lUQHZVkikKQjd9zp8guFaucciyAgABgboCAA1I/AIAA7cOA
Date:   Sun, 12 Sep 2021 23:28:13 +0000
Message-ID: <20210912232813.b5rajxu4ggywn2fh@shindev>
References: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
 <20210908083715.1831067-4-shinichiro.kawasaki@wdc.com>
 <20210910004857.GI1756565@dread.disaster.area>
 <20210910063405.j36w2oec2sqi6lob@shindev> <YT3FmvvytzCvWllt@desktop>
In-Reply-To: <YT3FmvvytzCvWllt@desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: eryu.me; dkim=none (message not signed)
 header.d=none;eryu.me; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1234ee5d-230f-43d3-56fe-08d97644fdfa
x-ms-traffictypediagnostic: BYAPR04MB5544:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5544E28E2E79D32862FA9216EDD89@BYAPR04MB5544.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3l+ciHr8zQsU3lKFgAJH6PNW1A7WtfAy1zNOqRpBmglbBHimXggsfImsswsbJsFX4U8lpuK8oB8O5HnbMMxx+IyuCOUi7RlDU6mE6ZB8NN6QrzVTRv1e7NEcJIVpVbUdrw4KACHGbaN4c+kXs4GG9OE10nMoA9OMXB9hagT+Tx3wJ3dhW8SauUbPf2ttswy/PxVM0EgUH93L/+3RkkhLPXbdLAVbLxKYy7mm00vfdAzMXQSjZsqUgHlCGgjhi6IHQ1myKA+D/vMSBea6iptPlj67GmErP/Ekp3LpGvgbN1aSflFWWda6sNFVAlRUDwQiaBg2yB+FpmxQKIfUswXF3dqfKpnlT8ZOZxbi0l1VFuSv3bUw9fV230kJInXk+yIcZJZkrF92h04PXJtO19JtCCAW29O6LeJCgzyKNAtL8SWBm1+Ci9WjsPD/kQQ29qfGsA1AtqHKP163Ee/5DKdFZlMH55AnXOeO3dWDHhvglICLzpgFQLZVFv7pA4XPxZARaocJHJgwUUlsXfcyrHMNjSp0xoVqD4uIM57W6HZtydLX2g1JpjwZTsjUUzO1a7gr6v4t15XA+dWOLc6CqreNwwW9eT/tXhzVQwRUjOfS+gNbF4cetjoLiLCpmE6yBDcC8XB825S3oWT1asl0NlmWAMoEbMpcb/llz2r9cxb2lJtOutjVL2PSE+c+Bib3n9CB/MGTR80WQsvOijvo6fSwkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(136003)(396003)(376002)(366004)(39860400002)(4326008)(38070700005)(478600001)(5660300002)(2906002)(38100700002)(33716001)(8936002)(86362001)(9686003)(6512007)(1076003)(66446008)(186003)(122000001)(66476007)(66556008)(64756008)(71200400001)(6486002)(76116006)(66946007)(316002)(26005)(83380400001)(6916009)(91956017)(8676002)(44832011)(54906003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d7mkUAKjUQcPAcOFg7PgZggkV1KsQ7JhW3k79cunY2lgaRBBwJ4DINHQeZxO?=
 =?us-ascii?Q?QUrliKT6fZCBxuWRd6dBr6BwP9BxrnAipZR+hsmwVL8Mbju3HTr+RG8UQF5b?=
 =?us-ascii?Q?lKITpdcddYwIL0IibF/BIUHBtLp+nOIFMPwvfsMQah3oN86NZ8rJmHdqfvSX?=
 =?us-ascii?Q?HKMKvZna/UAK3HFMthi8GP13nGplWv5MdKxXtMUcEX5Ys2rDiTFb/+DrhpWn?=
 =?us-ascii?Q?vL+uBLfjmMpFIv4A1j1CQW1kH+Qaw3NDbTOC1jWeramE8/Kthl1Pwy5TFJkf?=
 =?us-ascii?Q?d0UjE6KqRkxTI2WfMBLfXlDvamx/SaMDOArfYvkVqvgTu/0ViFtMOZlo4UY+?=
 =?us-ascii?Q?fPpAmx/h0DIf7Ajbne/BURa4IkvfsyOfpSrbSePU5tpDhjf+ovCd8ZxflINs?=
 =?us-ascii?Q?XINUt+tjux6QajIXHfzDxZlj98tPjQK/1jVGPNIkybLH7t+NvnRouSWOZeiL?=
 =?us-ascii?Q?H9CtAYeC8NLkDeEKPf0n2ql1lbWFLjBUCj/fsskFTW0vXs4/5FRr33QpSvzn?=
 =?us-ascii?Q?xmHG5ks62+ih2F+dao7YUC4PklVtURq5i8pA3yj1UswXferuyEJWLru8/v/6?=
 =?us-ascii?Q?xLlQV6mXJalPzZlzY6DYI/d5ac8FTRVZbrszoU+sGdyHR719ZTEaINJEEJCt?=
 =?us-ascii?Q?UaoCWLJZS1oNhMCD0psgif+nxOO/DEUi1Bv7Im5i82AbDs7qF/x2E70E1J1q?=
 =?us-ascii?Q?MICfb2M8g8vl4a6bhzfj+cZ3keN7Rm9ogrUKQbqLrowqWIw6Tr5ys75ExO68?=
 =?us-ascii?Q?VdkunEYPehyuM2bErtH2q8n2SoXRM1biEiCP+xJE+3pJarZHZZRjBz7HzgT3?=
 =?us-ascii?Q?64GTH49qmVhl3QDI1nTFen9oRmPlcYoHG+c7tEIrHFQZ1cW1JYGCGV13/2oh?=
 =?us-ascii?Q?FfZZO8HaChg3NSJimTFptgOD1RBdzJj99fqkeaQFZ3d6ldEIlnOfPg6KSqMd?=
 =?us-ascii?Q?5t1FmdJkLHzuWgV81cLMhDfvpxuQ/GkfmALJQr88ZBGFWKkowte9JBNsl20w?=
 =?us-ascii?Q?FoN1n4p0GogSYWPAQEf4WRZdCptNUrU2x2ciIiiokHeLn+K6kCCtsYppGfRt?=
 =?us-ascii?Q?7OI+nRSVCVpTbaQQ1Jf4cyejYxEYjQUEHXMTqoIzLz+h9l4xemsrxxgrrIEW?=
 =?us-ascii?Q?dZZwNGcYvBHHVrLNvxhe+4zDu8KevpXPRFpZwgPVi2q3xxnwb3Fr9EkxyFd4?=
 =?us-ascii?Q?Itldy06u59Q/iBlbh9B49SlXE5D5PKb60dfvpUWEjH7unsqgCs0EqCnVpeL1?=
 =?us-ascii?Q?on6G91ywxoq/hyGzLQAANnnvSaBjeFHgBbdAwN6OaFoDVTz6W7adHqjt15AO?=
 =?us-ascii?Q?Xdgpwpjr2C1mhp77v9Us1RZJOd7xeiYnkuYPiyfgUrjGeA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1234489E61D2404FBAE86694B6005C9A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1234ee5d-230f-43d3-56fe-08d97644fdfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2021 23:28:13.8132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2pSdqV9ZypAGU9z6jmBZHoBs2RjtTfOulCgdTHBg48Kim+vmgb3x264X1l0EUqcgZKjmAptigm9hSlvzE1VsMxebguIA7XQYeVOSsaDnEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5544
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sep 12, 2021 / 17:17, Eryu Guan wrote:
> On Fri, Sep 10, 2021 at 06:34:05AM +0000, Shinichiro Kawasaki wrote:
> > On Sep 10, 2021 / 10:48, Dave Chinner wrote:
> > > On Wed, Sep 08, 2021 at 05:37:15PM +0900, Shin'ichiro Kawasaki wrote:
> > > > When SCRATCH_DEV is not set and the test case does not call
> > > > _require_scratch* before _require_dm_target, _require_block_device
> > > > called from _require_dm_target fails to evaluate SCRATCH_DEV and
> > > > results in the test case failure. This failure reason is not descri=
bed
> > > > in the error message and it takes some time to catch.
> > >=20
> > > You should quote the actual failure message here so we have some
> > > idea of whether the message that was emitted was appropriate or not
> > > without having to go know how the test failed...
> >=20
> > Sorry about the lack of the infomration. As you found below, the meesag=
e was
> > "Usage: _require_block_device <dev>".
> >=20
> > >=20
> > > > To catch the failure reason easier, check SCRATCH_DEV in
> > > > _require_dm_target. If SCRATCH_DEV is not set, fail the test case
> > > > and print message which requests to fix call order of _require_scra=
tch*
> > > > and _require_dm_target. This improvement follows what _scratch_shut=
down
> > > > does for _require_scratch_shutdown.
> > >=20
> > > Also, you don't need to describe the change in the commit message -
> > > the patch does that. The first paragraph is all that is needed here
> > > as it describes why you want to make the change.
> >=20
> > I see. I will write "why" in the commit message, not "what". (In the pa=
st, I
> > was advised to write "what" the patch does, but I think this guide is v=
alid
> > only when the change is complicated).
> >=20
> > >=20
> > > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > ---
> > > >  common/rc | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/common/rc b/common/rc
> > > > index dda5da06..cbec8aaa 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -1971,6 +1971,9 @@ _require_dm_target()
> > > > =20
> > > >  	# require SCRATCH_DEV to be a valid block device with sane BLKFLS=
BUF
> > > >  	# behaviour
> > > > +	if [ -z "$SCRATCH_DEV" ]; then
> > > > +		_fail "_require_dm_target: call _require_scratch* first in test"
> > > > +	fi
> > > >  	_require_block_device $SCRATCH_DEV
> > > >  	_require_sane_bdev_flush $SCRATCH_DEV
> > > >  	_require_command "$DMSETUP_PROG" dmsetup
> > >=20
> > > That's a notrun case, not a fail.
> > >=20
> > > Also, we report the error that has occurred, not how to resolve the
> > > problem. That's because we might change behaviour in future and now
> > > the error message tells people to do something that is
> > > wrong/non-existent. As such, I think the premise this change is based
> > > on is not really valid - people running fstests are assumed to have
> > > a level of knowledge sufficient to trace a failing test and
> > > determine what went wrong from the error reported. i.e. the error
> > > message should state what the problem was, not describe a potential
> > > solution.
> >=20
> > Thank you for the comment. These are the points I missed. At least I wa=
s
> > able to catch the cause, so the improvement I suggested is not a big
> > improvement.
> >=20
> > >=20
> > > Also, this is not the place to check if SCRATCH_DEV is set. The
> > > check for a NULL device should be in _require_block_device(). Oh,
> > > wait, it already is:
> > >=20
> > > _require_block_device()
> > > {
> > > 	if [ -z "$1" ]; then
> > > 		echo "Usage: _require_block_device <dev>" 1>&2
> > > 		exit 1
> > > 	fi
> > > ....
> > > }
> > >=20
> > > And that's the error message the test emitted that you didn't
> > > understand, right?
> >=20
> > Right :)
> >=20
> > >=20
> > > If so, the change here should really be to _require_block_device().
> > > i.e.
> > >=20
> > > 	if [ -z "$1" ]; then
> > > 		_notrun "test requires a block device to be specified"
> > > 	fi
> > >=20
> > > A quick scan shows a bunch of similar _requires checks that do
> > > similar things with poor error messages and 'exit 1' (e.g.
> > > _require_local_device()). _requires rules should call _notrun if the
> > > test should not run because of incorrect setup, not 'exit 1'.
> >=20
> > Thank you for your thoughts. I walked through _require_* bash functions=
 in
> > common/, and listed 20 functions below, which call 'exit 1', _fail, or
> > 'return 1' for its argument check failure:
> >=20
> > --- list start ---
> >=20
> > common/rc
> >=20
> >   _require_scratch_size
> >   _require_scratch_size_nocheck
> >   _require_command *
> >   _require_block_device *
> >   _require_local_device *
> >   _require_zoned_device *
> >   _require_non_zoned_device *
> >   _require_scratch_ext4_feature
> >   _require_xfs_io_command
> >   _require_fio
> >   _require_batched_discard *
> >   _require_chattr
> >   _require_fs_sysfs
> >   _require_scratch_feature
> >=20
> > common/btrfs
> >=20
> >   _require_btrfs_mkfs_feature
> >   _require_btrfs_fs_feature
> >=20
> > common/xfs
> >=20
> >   _require_xfs_db_command
> >   _require_xfs_spaceman_command
> >=20
> > common/encrypt
> >=20
> >   _require_encryption_policy_support (checks arguments passed from _req=
uire_scratch_encryption)
> >=20
> > common/rnameat2
> >=20
> >   _require_renameat2
> >=20
> > --- list end ---
> >=20
> > Many of the functions above check arguments not for incorrect setup, bu=
t for
> > call in test cases with invalid arguments. 6 functions of them with * i=
n the
> > list check arguments for the incorrect setups, such as DEBUGFS_PROG,
> > SCRATCH_DEV or SCRATCH_MNT. So I suggest to modify these functions to i=
mprove
> > error messages and call "_notrun". What do you think about this?
>=20
> IMO the _fail calls in above _require* rules are indicating function
> usage errors, which are bugs in the test code. While _notrun indicates a
> required condition is not met for this test.

I see. I think the _require* rules with "exit 1" also indicates the usage e=
rrors
and the bugs. As Dave pointed out, it is assumed the fstests users have eno=
ugh
skill to identify the bug, then this improvement I suggested don't have muc=
h
value. I withdraw this suggestion. Dave and Eryu, thank you for the comment=
s.

>=20
> Thanks,
> Eryu
>=20
> P.S. I've applied the first two patches, thanks for the fix!

Thanks!

--=20
Best Regards,
Shin'ichiro Kawasaki=
